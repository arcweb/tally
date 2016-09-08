class EmergencyTimeRequest < TimeRequest
  def self.annual_allowance
    3
  end
  
  def display_text
    "Emergency"
  end
end