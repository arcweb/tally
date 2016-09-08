module OmniauthHelpers
  def callback_response
    OpenStruct.new(
      provider: 'google_oauth2',
      uid: 'garbage',
      info: OpenStruct.new(
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        image: Faker::Internet.url))
  end

  def callback_response_for_user(user)
    OpenStruct.new(
      provider: 'google_oauth2',
      uid: user.uid,
      info: OpenStruct.new(
        email: user.email,
        first_name: user.firstname,
        last_name: user.lastname,
        image: user.image))
  end

  def login_with_oauth(user)
    OmniAuth.config.add_mock(:google_oauth2, {
      uid: user.uid,
      info: {
        email: user.email,
        first_name: user.firstname,
        last_name: user.lastname,
        image: user.image
      }
    })
    login_as user, scope: :user
  end
end

RSpec::Matchers.define :equal_auth_callback do |expected|
  match do |actual|
    actual.email == expected.info.email and
    actual.firstname == expected.info.first_name and
    actual.lastname == expected.info.last_name and
    actual.image == expected.info.image
  end
end