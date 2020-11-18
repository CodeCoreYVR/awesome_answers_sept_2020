class AddUserReferencesToQuestions < ActiveRecord::Migration[6.0]
  # rails g migration add_user_references_to_questions user:references
  # 👆🏻 This migration was generated with the help of above terminal command
  def change
    add_reference :questions, :user, foreign_key: true
  end
end
