class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @books = Book.all
    respond_with(@books)
  end

  def show
    respond_with(@book)
  end

  def new
    @book = current_user.books.new
    @book.authors.build
    @book.attachments.build
    respond_with(@book)
  end

  def edit
  end

  def create
    @book = current_user.books.new(book_params)
    @book.save
    respond_with(@book)
  end

  def update
    @book.update(book_params)
    respond_with(@book)
  end

  def destroy
    @book.destroy
    respond_with(@book)
  end

  private
    def set_book
      @book = Book.find(params[:id])
      @authors = @book.authors
      @attachments = @book.attachments
    end

    def book_params
      params.require(:book).permit(:title, :user_id, :cover,
            authors_attributes: [:id, :name, :_destroy],
            attachments_attributes: [:id, :file, :book_id, :_destroy])
    end
end
