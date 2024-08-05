# spec/factories/books.rb
FactoryBot.define do
    factory :book do
      title { 'Test Book' }
      association :author
    end
  end
  