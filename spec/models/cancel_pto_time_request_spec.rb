RSpec.describe CancelPtoTimeRequest, type: :model do

describe :approve do

  let(:request) { FactoryGirl.create(:cancel_pto_time_request) }
  let(:day_to_destroy) { FactoryGirl.create(:vacation_day, date_taken: request.requested_days.first.date_requested) }

  it 'destroys the associated vacation day' do

    expect {
       request.approve
     }.to change(request, :status).from('pending').to('approved')
     .and change { VacationDay.exists? day_to_destroy.id }.from(true).to(false)
    
  end

end

end
