class BooksController < ApplicationController
  include SimpleCrud::Base

  model :book, includes: :authors, includes: :attachments,
        order: "created_at DESC"

=begin
  - index: add format csv
  - show: ok
  - new: add builds
  - create: add params correctly
  - update: ^^
  - delete: undefined scope
=end

  private
    def book_params
      params.require(:book).permit(:title, :user_id, :cover,
            authors_attributes: [:id, :name, :_destroy],
            attachments_attributes: [:id, :file, :book_id, :_destroy])
    end
end
