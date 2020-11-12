class RemoveColumnsFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :like_count, :integer
    remove_column :questions, :is_archived, :integer
    remove_column :questions, :is_active, :boolean
  end
end
