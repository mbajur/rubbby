class Tag < ActiveRecord::Base
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  scope :accepted, -> { where is_accepted: true }
  scope :hot,      -> { order projects_count: :desc }
  scope :top,      -> { order projects_count: :desc }
  scope :recent,   -> { order created_at: :desc }

  private
    def slug_candidates
      [
        :name,
        [:name, :id]
      ]
    end

end
