FactoryBot.define do
  sequence :name do |n|
    "string_#{n}"
  end
end
