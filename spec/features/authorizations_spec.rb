require 'rails_helper'
include OmniauthHelpers
require 'cancan/matchers'

def has_permission
  expect(page).to_not have_text "You are not authorized to access this page."
end

def lacks_permission
  expect(page).to have_text "You are not authorized to access this page."
end

describe "Authorizations" do
  let(:ability) { Ability.new(user) }
  let(:user) { nil }

  context "when admin" do
    let(:user) { FactoryGirl.create(:admin)}

    it "can view all user profiles" do
      expect(ability).to be_able_to(:manage, :all)
    end
  end

  context "when user" do
    let(:user) { FactoryGirl.create(:user) }

    it "can view it's own profile" do
      expect(ability).to be_able_to(:show, user)
    end

    it "cannot view other profiles" do
      expect(ability).to_not be_able_to(:show, User.new)
    end
  end
end
