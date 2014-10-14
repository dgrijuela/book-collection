class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :attachments, :book_id
    add_index :books, :user_id
    add_index :book_author_relations, :book_id
    add_index :book_author_relations, :author_id
  end
end
