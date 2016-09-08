class RequestedDay < ActiveRecord::Base  
  def date_requested(format=nil)
    case format
    when :long
      read_attribute(:date_requested).strftime("%A, %B %-d %Y")
    when :short
      read_attribute(:date_requested).strftime("%a, %b %-d %Y")
    else
      read_attribute(:date_requested)
    end
  end
end
