class Like < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates(
    :question_id,
    uniqueness: {
      scope: :user_id,
      message: "you cant like multiple times!!!!"
    }
  )
  # scoping uniqueness:
  # <question_id: 1, user_id: 1> 👍
  # <question_id: 1, user_id: 2> 👍
  # <question_id: 1, user_id: 1> 👎
  
  # without scoping
  # <question_id: 1, user_id: 1> 👍
  # <question_id: 1, user_id: 2> 👎
end
