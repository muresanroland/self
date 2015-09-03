class WelcomeController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        pagination = {
            next: root_url(date: @date - 1.month, format: :json),
            previous: root_url(date: @date + 1.month, format: :json)
        }

        render json: Event.date_stats_from_beginning_of_month(@date).merge(pagination)
      end

      format.html { }
    end
  end
end
