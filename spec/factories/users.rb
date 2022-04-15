FactoryBot.define do
    factory :user do
        email { Faker::Internet.email }
        password { 'password' }
    end

    # userを作った際に、下記を記載しておくと一緒にprofileも作ってくれる
    trait :with_profile do
        after :build do |user|
            build(:profile, user: user)            
        end
    end
end