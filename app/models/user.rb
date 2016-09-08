class User < ActiveRecord::Base
  # CanCanCan
  # ============================================
  ROLES = %w(admin user)

  ROLES.each do |role|
    define_method("#{role}?") { self.role == role }
  end

  # Devise
  # ============================================
  devise  :rememberable, 
          :trackable, 
          :omniauthable, omniauth_providers: [:google_oauth2]

  # Validators
  # ============================================

  validates :total_pto, :used_pto, :carryover_pto, :bonus_pto, presence: true

  # Relationships
  # ============================================
  has_many :vacation_days
  has_many :time_requests

  before_create :set_total_pto

  # Class Methods
  # ============================================
  default_scope -> { where(active: true) }
  default_scope -> { order(:firstname) }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      user.image = auth.info.image 
    end
  end

  # Instance Methods
  # ============================================
  def vacation_days_for_current_year
    self.vacation_days.select { |day| day.is_current_year? }.sort_by {|day| day.date_requested}.reverse
  end

  def set_total_pto
    self.total_pto = 16
  end

  def monthly_vacation_count
    Date::ABBR_MONTHNAMES.from(1).inject({}) do |hash, month|
      hash[month] = vacation_day_count_for_month(month)
      hash
    end
  end

  def vacation_day_count_for_month(month)
    days = vacation_days_for_current_year.inject(0) do |count, day|
      count += day.days_requested if day.month?(month) 
      count
    end
    strip_trailing_zeros(days)
  end

  def emergency_requests_taken
    time_requests.where(type: "EmergencyTimeRequest").count
  end

  def used_pto
    vacation_days_for_current_year.inject(0) do |count, day|
      count += day.days_requested
      count
    end
  end

  def remaining_pto
    (total_pto + carryover_pto + bonus_pto) - used_pto
  end

  def annual_pto
    total_pto + carryover_pto + bonus_pto
  end

  def archive
    self.update_attribute :active, false
  end

  def pending_requests
    TimeRequest.pending.where(user_id: self.id)
  end

  # Private Methods
  # ============================================
  private
  
  def strip_trailing_zeros(value)
    value == value.to_i ? value.to_i : value
  end
end
