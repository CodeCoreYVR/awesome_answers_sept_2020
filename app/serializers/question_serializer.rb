class QuestionSerializer < ActiveModel::Serializer
  # `rails g serializer question` to generate a serializer for a model
  # Before rails sends JSON it will check to see if there is a serializer with the same name
  attributes(
    :id,
    :title,
    :body,
    :randomstuff,
    :view_count,
    :created_at,
    :updated_at,
    :like_count
  )

  # To include associated models, use the same named method for creating associations
  # you can re-name the association with a key.
  belongs_to :user, key: :author
  has_many :answers

  class AnswerSerializer < ActiveModel::Serializer 
    attributes(
      :id,
      :body,
      :created_at
    )
  end

  def randomstuff
    "random stuff serializer has added to json response"
  end

  def like_count
    # object referenced within any method is the instance of the model being serialized. Kind of like "this" in javascript or "self" in ruby.
    object.likes.count
  end
end
