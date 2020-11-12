class AddLikeCountToQuestions < ActiveRecord::Migration[6.0]
  # Step 1: rails g migration AddLikeCountToQuestions 
  # Step 2: Modify newly created migration file according to our own need
  # Step 3: Run migration using rails db:migrate
  def change
    add_column :questions, :like_count, :integer
  end
end
