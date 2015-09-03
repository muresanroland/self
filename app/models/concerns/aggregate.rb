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

    def around(date, r=2)
      ((date - r.days)..(date + r.days)).inject({}) { |h, d| h[d] = at(d).all || []; h }
    end

    def date_stats_from_beginning_of_month(date)
      events = Event.where('worked_at >= ? AND worked_at <= ?', date.beginning_of_month, date.end_of_month)
      dates = Hash.new

      (date.beginning_of_month..date.end_of_month).each { |d| dates[d] = false }
      events.pluck(:worked_at).uniq.each { |e| dates[e] = true }

      {
          current_date: date,
          dates: dates
      }
    end
  end
end