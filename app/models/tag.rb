class Tag < ActiveRecord::Base

  scope :accepted, -> { where(is_accepted: true) }

end
