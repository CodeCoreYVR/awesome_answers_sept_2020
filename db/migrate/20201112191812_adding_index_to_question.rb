class AddingIndexToQuestion < ActiveRecord::Migration[6.0]
  # This migration file was generated with the help of this command👇🏻
  # rails g migration AddingIndexToQuestion
  def change
    add_index :questions, :title
    add_index :questions, :body
  end
end
