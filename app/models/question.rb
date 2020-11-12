class Question < ApplicationRecord
# 👆🏻Question Class inherits from ApplicationRecord

after_initialize :set_defaults # it is generally usefull to set the default values
before_save :capitalize_title # it will work when before the data is saved to db

# def self.recent_ten
#     order("created_at DESC").limit(10)
# end
scope :recent_ten, lambda{order("created_at DESC").limit(10)}

# rails g model question title:string body:text
# "rails" is console keyward that we use
# g / generate :  this is used to generate models, migrations, controllers etc
# model : We used keyword model because we want to generate a model
# title:string / body:text is the column name and column type of the database

#  We can use following terminal commands to drop and create database
# rails db:drop 👈🏻This will drop or delete database in postgres
# rails db:create 👈🏻This will create database in db server i.e. postgres
# rails db:reset 👈🏻This command is combination of db:drop and db:create

# Following commands are usefull while performing rollback on migrations
#  rails db:rollback 👈🏻this will rollback one migration at a time
# rails db:rollback STEP=3 👈🏻This will rollback three migrations in one shot

# Never edit schema by yourself, always use migrations to make changes
# Never edit migration without rail db:rollback

# validates :title, presence: true

# q=Question.save
# q.save
# it will not save the record because of validation
# q.errors # this is will return a hash of arrays include errors messages
# q.errors.full_messages 👉🏻 This will give an array of full messages => ["Title can't be blank"] 

# validates :title, presence: {message: "title must be provided"}

# validates :title, uniqueness: true

validates :title , length: {minimum: 2, maximum: 20}

validates :view_count, numericality: {greater_than_or_equal_to: 0}

validate :no_monkey
private
def no_monkey
    # "&." is the safe navigation operator. it is uesd like "." to call methods on an object.
    #  if the method doesn't exsist for the object, 'nil' will be returned instead of getting errors 
    if body&.downcase&.include?("monkey")
        self.errors.add(:body,"Must not have monkey")
    end

end

def set_defaults
    self.view_count ||=0
end
def capitalize_title
    self.title.capitalize!
end

end
