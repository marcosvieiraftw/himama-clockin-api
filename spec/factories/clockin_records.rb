FactoryBot.define do
  factory :clockin_record do
    association :user, factory: :user
    register_type { 'in' }
    register_date { Time.now }
  end
end
