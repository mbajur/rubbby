class Stats < ActiveRecord::Base
  belongs_to :project

  scope :today, -> { where('created_at >= ?', DateTime.now.beginning_of_day).where('created_at <= ?', DateTime.now.end_of_day) }
end
