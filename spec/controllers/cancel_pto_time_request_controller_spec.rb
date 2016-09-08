require 'rails_helper'

RSpec.describe CancelPtoTimeRequestsController, type: :controller do

  describe '#create' do 

    describe 'as a normal user' do
    
      it 'creates a cancellation request' do
        user = FactoryGirl.create(:user)
        sign_in user

        day_to_cancel = FactoryGirl.create(:vacation_day, user: user)
        
        expect {
          delete :create, id: user.id, vacation_day_id: day_to_cancel.id
        }.to change(CancelPtoTimeRequest, :count).by 1

        expect(CancelPtoTimeRequest.last.requested_days.first.date_requested).to eq day_to_cancel.date_requested

        assert_response 200
      end

    end

    describe 'as an admin' do
      
      it 'deletes the related vacation day' do
        user = FactoryGirl.create(:admin)
        sign_in user

        day_to_cancel = FactoryGirl.create(:vacation_day, user_id: rand(100))

        expect {
          delete :create, id: day_to_cancel.user_id, vacation_day_id: day_to_cancel.id
        }.to change(VacationDay, :count).by(-1)
        .and change { VacationDay.exists? day_to_cancel.id }.from(true).to(false)

        assert_response 200

        expected_response =  {status: :ok,
                              type: "CancelPtoTimeRequest",
                              vacation_day_id: day_to_cancel.id.to_s }.to_json
        expect(response.body).to eq expected_response
      end

    end

  end

end
