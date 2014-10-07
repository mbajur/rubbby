class Stats < ActiveRecord::Base
  belongs_to :project

  scope :today, -> {
    where('created_at >= ?', DateTime.now.beginning_of_day).where('created_at <= ?', DateTime.now.end_of_day)
  }
  scope :this_month, -> {
    where('created_at >= ?', DateTime.now.beginning_of_month).where('created_at <= ?', DateTime.now.end_of_month)
  }
  scope :last_month, -> {
    where('created_at >= ?', DateTime.now.beginning_of_month - 1.month).where('created_at <= ?', DateTime.now.end_of_month - 1.month)
  }

  def calculate_points
    stargazers_count + \
    forks_count + \
    subscribers_count
  end

  def self.gain_for_month(attribute, datetime)
    s = self
      .where('created_at >= ?', datetime.beginning_of_month)
      .where('created_at <= ?', datetime.end_of_month)

    return 0 unless s.any?

    s.last.send(attribute) - s.first.send(attribute)
  end

  def self.percentage_gain_this_month(attribute)
    last_month = self.gain_for_month(attribute, DateTime.now.beginning_of_month - 1.month)
    this_month = self.gain_for_month(attribute, DateTime.now)

    return 100 if last_month == 0
    inc = (100 * this_month) / last_month

    # Gain is always a positive value so we need to
    # add a minus if it should be negative.
    (last_month > this_month) ? -inc : inc
  end
end
