FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email } 
    firstname             { Faker::Name.first_name }
    lastname              { Faker::Name.last_name }
    image                 { Faker::Internet.url }
    provider              'google_oauth2'
    uid                   { Faker::Number.number(10) }
    role                  'user'
    total_pto             16
  end

  factory :admin, parent: :user do
    role                  'admin'
  end
end
