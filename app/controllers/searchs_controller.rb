class SearchsController < ApplicationController
  def result
    @books = Book.search(params[:search])
  end
end
