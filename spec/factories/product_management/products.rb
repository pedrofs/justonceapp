FactoryBot.define do
  factory :product, class: 'ProductManagement::Product' do
    name { 'MyString' }
  end
end
