class Answers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.text :body
      # https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_reference
      t.references :question, null: false, foreign_key: true
      t.timestamps
    end
  end
end
