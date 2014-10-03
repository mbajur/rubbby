class Tag < ActiveRecord::Base
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  scope :accepted, -> { where(is_accepted: true) }

  private
    def slug_candidates
      [
        :name,
        [:name, :id]
      ]
    end

end
