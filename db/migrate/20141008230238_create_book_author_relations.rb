class CreateBookAuthorRelations < ActiveRecord::Migration
  def change
    create_table :book_author_relations do |t|
      t.integer :book_id
      t.integer :author_id

      t.timestamps
    end
  end
end
