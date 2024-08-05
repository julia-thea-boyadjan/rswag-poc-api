module Api
  module V1
    class BooksController < ApplicationController
      def index
        render json: Book.all
      end

      def show
        @book = Book.includes(:author).find_by(id: params[:id])
        if @book
          render json: @book.as_json(include: :author), status: :ok # 200 OK
        else
          render json: { error: 'Book not found' }, status: :not_found # 404 Not Found
        end
      end
    

      def create
        author = Author.find_or_create_by(first_name: params[:author][:first_name], last_name: params[:author][:last_name])
        book = Book.new(title: params[:title], author: author)

        if book.save
          render json: book.as_json(include: :author), status: :created
        else
          render json: { errors: book.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        book = Book.find_by(id: params[:id])
      
        if book
          book.destroy
          head :no_content
        else
          render json: { error: 'Book not found' }, status: :not_found
        end
      end
      

      # private

      def book_params
      #   params.require(:book).permit(:title, :author)
      params.require(:book).permit(:title, author: [:first_name, :last_name])

      end
    end
  end
end
