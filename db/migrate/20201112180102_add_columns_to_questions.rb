class AddColumnsToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :is_archived, :integer
    add_column :questions, :is_active, :boolean
  end
end
