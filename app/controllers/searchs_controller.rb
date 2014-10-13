class SearchsController < ApplicationController
  def result
    @search_params = params[:search]
    @books = Book.search(@search_params)
  end
end
