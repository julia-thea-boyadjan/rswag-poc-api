require 'rails_helper'

describe "Books API", type: :request do

  let!(:author) { FactoryBot.create(:author, first_name: "JK", last_name: "Rowling", age: 55) }

  describe "GET /books" do
    before do
      FactoryBot.create(:book, title: "Harry Potter 1", author: author)
      FactoryBot.create(:book, title: "Harry Potter 2", author: author)
    end

    it "returns all books" do
      get "/api/v1/books"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to equal(2)
    end
  end

  # describe "POST /books" do

  #   it "creates a new book" do
  #     expect {
  #       post "/api/v1/books", params: 
  #       { 
  #         book: { title: "Harry Potter 3" },
  #         author: { first_name: "YO", last_name: "Yo", age: 55}
  #       }
  #      }.to change { Book.count }.from(0).to(1)

  #      print "YOYO: " + params

  #      expect(response).to have_http_status(:created)
  #   end
  # end

  describe "DELETE /books" do
    let!(:book) { FactoryBot.create(:book, title: "Harry Potter 4", author: author) }

    it "deletes a book" do
      expect {
        delete "/api/v1/books/#{book.id}"
    }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
  
end
