class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {unique: true}
      # By adding index, It will improve the performance of that query significantly. The speed is achieved by creating ordered list that gives database faster way to search, Example of a book without index , harder to find particular chapter without it.
      t.string :password_digest

      t.timestamps
    end
  end
end
