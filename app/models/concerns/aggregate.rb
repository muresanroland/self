require 'active_support/concern'

module Aggregate
  extend ActiveSupport::Concern

  included do
    scope :at, ->(d) { where(worked_at: d) }
    scope :between, ->(d1,d2) do
      if d2
        where 'events.worked_at >= ? AND events.worked_at <= ?', d1, d2
      else
        where 'events.worked_at >= ?', d1
      end
    end
  end

  def duration
    hours.hours + minutes.minutes
  end

  def duration_in_hours
    duration / 3600.0
  end

  def compute_amount
    hourly_rate = ot? ? rate.hourly_rate_ot : rate.hourly_rate rescue 0
    hourly_rate * duration_in_hours
  end

  class_methods do
    def total
      sum(:hours).hours + sum(:minutes).minutes
    end

    def total_amount
      sum(:amount)
    end

    def around(date)
      ((date - 2.days)..(date + 2.days)).inject({}) { |h, d| h[d] = at(d).all || []; h }
    end
  end
end