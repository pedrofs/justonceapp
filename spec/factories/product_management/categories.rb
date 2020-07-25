FactoryBot.define do
  factory :category, class: 'OrderManagement::Category' do
    name { 'MyString' }
    home_id { '' }
  end
end
