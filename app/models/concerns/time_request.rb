class TimeRequest < ActiveRecord::Base
  # Relationships
  # ============================================
  belongs_to :vacation_day
  belongs_to :user

  # Class Methods
  # ============================================
end