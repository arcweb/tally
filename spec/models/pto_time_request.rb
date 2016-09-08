require 'rails_helper'

RSpec.describe PtoTimeRequest, type: :model do

 it "has the correct defaults" do
   request = FactoryGirl.build_stubbed :pto_time_request
   expect(request.status).to eq "pending"
 end

 describe :approve do
   let(:num_days) { 4 }
   let(:time_request) { FactoryGirl.create(:pto_time_request, num_days: num_days) }

   it 'approves request, adds vacation days, and sends an email' do
     expect(RequestStatusMailer).to receive(:send_status_email).and_return( double("Mailer", deliver_now: true))

     expect {
       time_request.approve
     }.to change(time_request, :status).from('pending').to('approved')
     .and change { VacationDay.count }.by num_days
   end
 end

 describe :deny do
   let(:time_request) { FactoryGirl.build_stubbed :pto_time_request }

   it 'denies the request and sends an email' do 
     expect(RequestStatusMailer).to receive(:send_status_email).and_return( double("Mailer", deliver_now: true))
     expect {
       time_request.deny
     }.to change(time_request, :status).from('pending').to('denied')
     .and change(VacationDay, :count).by 0
   end

 end

end
