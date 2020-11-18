class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true
  # belongs_to is an association method to let ActiveRecord (Rails ORM) know that this model "Answer" has a belongs to association to the Question Model
  # More on belongs_to here https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-belongs_to

  # .question => returns teh question that the answer instance belongs to
end
