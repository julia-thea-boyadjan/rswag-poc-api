# spec/integration/api/v1/books_spec.rb
require 'swagger_helper'

RSpec.describe 'API V1 Books', type: :request do
  path '/api/v1/books' do
    get 'Retrieves a list of books' do
      tags 'Books'
      produces 'application/json'
      response '200', 'Books retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   author: { type: :string },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: [ 'id', 'title', 'author', 'created_at', 'updated_at' ]
               }

        run_test!
      end
    end
  end

  path '/api/v1/books/{id}' do
    get 'Retrieves a book' do
      tags 'Books'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the book'

      response '200', 'book found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 author: { 
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     first_name: { type: :string },
                     last_name: { type: :string }
                   },
                   required: [ 'id', 'first_name', 'last_name' ]
                 }
               },
               required: [ 'id', 'title', 'author' ]

        let(:id) { FactoryBot.create(:book).id }

        run_test!
      end

      response '404', 'book not found' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: [ 'error' ]

        let(:id) { -1 }  # Assumes that a book with ID -1 doesn't exist

        run_test!
      end
    end
  end

  path '/api/v1/books' do
    post 'Creates a book' do
      tags 'Books'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          author: { 
            type: :object,
            properties: {
              first_name: { type: :string },
              last_name: { type: :string }
            }
          }
        },
        required: [ 'title', 'author' ]
      }

      response '201', 'book created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 author: { 
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     first_name: { type: :string },
                     last_name: { type: :string }
                   }
                 },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: [ 'id', 'title', 'author', 'created_at', 'updated_at' ]

        let(:author) { { first_name: 'Test', last_name: 'Author' } }
        let(:book) { { title: 'Test Book', author: author } }

        run_test!
      end

      response '422', 'unprocessable entity' do
        schema type: :object,
               properties: {
                 errors: { type: :object }
               },
               required: [ 'errors' ]

        let(:author) { { first_name: 'Test', last_name: 'Author' } }
        let(:book) { { title: '', author: author } }

        run_test!
      end
    end
  end


  path '/api/v1/books/{id}' do
    delete 'Deletes a book' do
      tags 'Books'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the book to delete'
  
      response '204', 'book deleted' do
        let!(:author) { create(:author, first_name: 'Test', last_name: 'Author') }
        let!(:book) { create(:book, title: 'Test Book', author: author) }
        let(:id) { book.id }  # Define the id parameter
  
        run_test! do |response|
          expect(response.status).to eq(204)
          expect(Book.find_by(id: book.id)).to be_nil
        end
      end
  
      response '404', 'book not found' do
        let(:id) { 'non-existing-id' }  # Define a non-existing id
        
        run_test! do |response|
          expect(response.status).to eq(404)
          expect(JSON.parse(response.body)).to eq('error' => 'Book not found')
        end
      end
    end
  end
  
end
