class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.email.include?("arcwebtech.com")
      @user.save unless @user.persisted?
      sign_in :user, @user
      redirect_to @user.admin? ? users_path : @user
    else
      render(file: "public/401.html", status: :unauthorized, layout: false)
    end
  end

  def after_omniauth_failure_path_for(scope)
    home_path
  end
end