require 'rails_helper'

describe Users::OmniauthCallbacksController, type: :controller do 
  describe :google_oauth2 do
    context "for a user with an arcweb email" do
      before do
        get :google_oauth2
      end
      
      it "creates a new user" do
      end

      it "redirects to that user's profile" do
      end
    end 

    context "for a user without an arcweb email" do
      it "returns a 401 error" do
      end
    end
  end 
end