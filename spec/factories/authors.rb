# FactoryBot.define do
#   factory :author do
#     # first_name { "MyString" }
#     # last_name { "MyString" }
#     # age { 1 }
#   end
# end

# spec/factories/authors.rb
FactoryBot.define do
  factory :author do
    first_name { "Test First" }
    last_name { "Test Last" }
  end
end
