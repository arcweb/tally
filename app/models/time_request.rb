class TimeRequest < ActiveRecord::Base 
  enum status: [:pending, :approved, :denied, :cleared]

  # Relationships
  # ============================================
  has_many :requested_days
  belongs_to :vacation_day
  belongs_to :user

  accepts_nested_attributes_for :requested_days

  default_scope -> { order(:created_at => :desc) }

  # Class Methods
  # ============================================
  before_create :set_default_status

  def self.request_types
    {
      "PTO" => "PtoTimeRequest",
      "Remote (reason required)" => "RemoteTimeRequest",
      "Sick" => "SickTimeRequest",
      "Emergency (reason required)" => "EmergencyTimeRequest",
      "Maternity/Paternity" => "MaPaternityTimeRequest",
      "Jury Duty" => "JuryDutyTimeRequest"
    }
  end

  def self.create_and_notify(time_request)
    request = TimeRequest.create(time_request) 
    TimeRequestMailer.send_new_request(request).deliver_now
  end

  def set_default_status
    self.status = TimeRequest.statuses[:pending]
  end

  def display_text
  end

  def abbr_text
    display_text
  end

  def class_name
    self.class.name
  end

  def as_json(options={})
    super({
      only: [ 
        :id,
        :status,
        :reason,
        :created_at,
        :display_text,
        :abbr_text
      ],
      include: [
        :user,
        :requested_days
      ],
      methods: [
        :abbr_text,
        :display_text,
        :class_name
      ]
    })
  end
end
