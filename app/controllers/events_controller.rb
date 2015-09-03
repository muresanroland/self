class EventsController < ApplicationController
  respond_to :html
  respond_to :js, only: [:create, :update]

  after_filter :publish_event_to_keen

  def index
    respond_to do |format|
      format.json do

        render json: {
                   projects: current_user.projects.map do |project|
                     events = current_user.events.where(project_id: project.id, worked_at: @date).map do |e|
                       {
                           duration: e.duration / 3600.0,
                           description: e.description,
                           total: e.amount
                       }
                     end

                     { project.name => events }
                   end.reduce(:merge)
               }
      end

      format.html { redirect_to root_path }
    end
  end

  def data_table
    respond_to do |format|
      format.json do
        collection = current_user.events.joins 'LEFT JOIN projects ON projects.id = events.project_id'
        render json: EventDataTable.new(view: view_context, relation: collection)
      end
      format.html { redirect_to root_path }
    end
  end

  def create
    @event = Event.new permitted_params
    @success = @event.save
    @date = @event.worked_at
    respond_with @event, location: -> { root_path(date: permitted_params[:worked_at]) }
  end

  def update
    @event = Event.find params[:id]
    @success = @event.update permitted_params
    @date = @event.worked_at
    respond_with @event, location: -> { root_path(date: permitted_params[:worked_at]) }
  end

  def destroy
    @event = Event.find params[:id]
    @event.destroy
    flash[:notice] = 'Event successfully removed'
  rescue
    flash[:alert] = 'Unable to remove event!'
  ensure
    redirect_to root_path(date: @event.worked_at)
  end

  private
  def permitted_params
    params.require(:event).permit :hours, :minutes, :description, :project_id, :user_id, :worked_at, :ot
  end

  def publish_event_to_keen
    if @event && (@event.persisted? || @event.destroyed?)
      publish_keen collection: :events, event: @event.to_keen( action: params[:action])
    end
  rescue
    # don't care about issues with +Keen+
  end
end
