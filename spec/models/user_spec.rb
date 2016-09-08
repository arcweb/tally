require 'rails_helper'
include OmniauthHelpers

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it "has a valid factory" do
    expect(user).to be_valid
  end

  describe "class methods" do
    describe :from_omniauth do
      let(:omniauth_user) { User.from_omniauth(@auth) }

      context "for a new user" do
        before { @auth = OmniauthHelpers::callback_response }

        it "populates a new user without saving" do
          expect(omniauth_user).to equal_auth_callback @auth
          expect(omniauth_user.id).to eq nil
        end
      end

      context "for an existing user" do
        before { @auth = OmniauthHelpers::callback_response_for_user user }

        it "returns the existing user" do
          expect(omniauth_user).to equal_auth_callback @auth
          expect(omniauth_user.id).to eq user.id
        end
      end
    end
  end

  describe "instance methods" do
    describe "for calculating pto" do
      before do
        user.vacation_days << FactoryGirl.create_list(:vacation_day, 4) 
        user.vacation_days << FactoryGirl.create(:vacation_day, date_taken: 1.month.from_now)
      end

      describe :used_pto do
        it "returns the number of vacation days approved" do
          expect(user.used_pto).to eq 5
        end
      end

      describe :remaining_pto do
        it "returns the difference between used pto and remaining" do
          expect(user.remaining_pto).to eq 11
        end
      end
    end
  end

  describe "relationships" do
    describe :vacation_days do
      it "can be created" do     
        expect{user.vacation_days.create(FactoryGirl.attributes_for(:vacation_day))}.to change{user.vacation_days.count}.by(1)
      end

      describe :monthly_vacation_count do
        before do
          user.vacation_days << FactoryGirl.create(:vacation_day, date_taken: "#{Date.today.year}-01-31") 
          user.vacation_days << FactoryGirl.create(:vacation_day, date_taken: "#{Date.today.year}-03-16")
          user.vacation_days << FactoryGirl.create(:vacation_day, date_taken: "#{Date.today.year}-05-21")
          user.vacation_days << FactoryGirl.create(:vacation_day, date_taken: "#{Date.today.year}-08-30")
        end

        it "returns a hash of months and the vacation days taken in them" do
          expect(user.monthly_vacation_count).to eq({
            "Jan" => 1,
            "Feb" => 0,
            "Mar" => 1,
            "Apr" => 0,
            "May" => 1,
            "Jun" => 0,
            "Jul" => 0,
            "Aug" => 1,
            "Sep" => 0,
            "Oct" => 0,
            "Nov" => 0,
            "Dec" => 0
          })
        end
      end
    end
  end
end
