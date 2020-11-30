class Question < ApplicationRecord

    has_many :answers, dependent: :destroy
    belongs_to :user, optional: true
    # creates a has_many association between Question and Answer
    # now you have additonal methods to query the association. More info at https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many
    # 👆🏻Question Class inherits from ApplicationRecord

    # has_and_belongs_to_many(
    #     :likes, #name of the association
    #     class_name: 'User', #model that is used in the association
    #     join_table: 'likes', # join table for the many_to_many relationship
    #     association_foreign_key: 'user_id', # within the join table this is the foreign key to the class_name (Model of the association)
    #     foreign_key: 'question_id' # within the join table is the foreign key to this Model
    # )

    has_many :likes
    has_many :likers, through: :likes, source: :user

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings#,source : :tag
    # if the name of the association(i.e tags) is same as the 
    # source singularized(i.e. tag), then the source namded argument can be omitted

after_initialize :set_defaults # it is generally usefull to set the default values
before_save :capitalize_title # it will work when before the data is saved to db

# def self.recent_ten
#     order("created_at DESC").limit(10)
# end
scope :recent_ten, lambda{order("created_at DESC").limit(10)}

# def self.search(query)
#     where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%")
# end
# 👆🏻Converted into lambda👇🏻
scope(:search,->(query){where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%")})


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

# validates :title , length: {minimum: 2, maximum: 20}
# - The first arguments(s) are column names
  # - The last arguments are key->value arguments
  #   describing the rules to enforce
  validates(:title, presence: true, uniqueness: true)
  # - presence rule means that the title must exist
  # - uniqueness rule means that all questions must have
  #   different titles

validates :view_count, numericality: {greater_than_or_equal_to: 0}

validate :no_monkey

def tag_names
    self.tags.map(&:name).join(', ')
    # The & symbol is used to tell Ruby that the following argument should be treated as a block given to the method. So the line:
    # self.tags.map(&:name).join(', ')
    # is equivalent to:
    # self.tags.map{|x| x.name}.join(', ')
    # so the above method will iterate over the collection self.tags
    # and build an array with the results of the name method called on every item.
    # Then we just join the array into a comma seperated string
end
# This is simmillar to implementing an 'attr_writer'
def tag_names=(rhs)
    self.tags= rhs.strip.split(/\s*,\s*/).map do|tag_name|

    #    Finds the first record with the given attributes or initializes a 
    # record (Tag.new)  with the attributes if one is not found
        Tag.find_or_initialize_by(name: tag_name)
# if a tag with name tag_name is not found,
# it will call Tag.new(name: tag_name) 

    end

end

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

##### Notes On Active Records

# A C T I V E    R E C O R D 
    # Fetch All Questions
    # questions = Question.all 👈 this will give us back the list of questions as an object
    # the object behaves like an array so you can call methods on it like (.each) and you
    # can also chain it with other methods to do other types of operations and queries

    # Creating a new question
    # To create a new question object in memory do:
    # q = Question.new
    # you can also pass in a hash to the new method as in:
    # q = Question.new({ title: 'To be or not to be', body: 'is that a question?', view_count: 0 })
    # or for short:
    # q = Question.new title: 'To be or not to be }, body: 'is that a question?', view_count: 0 

    # to save the above question into questions table:
    # q.save 👈 this will save that above question into the questions table (persist it)

    # Creating a record right away
    # you can create a record right away in the database using (.create) method as in:
    # Question.create({ title: 'My Question Title', body: 'My question body', view_count: 1 })

    # Fetching Records
    # .first
    # Question.first 👈 fetches the first record ordered by the id in an ascending order
    # The sql equivalent:
    # SELECT "questions".* FROM "questions" ORDER BY "questions"."id" ASC LIMIT 1;

    # .last
    # Question.last 👈 fetches the last record ordered by the id in an ascending order 
    # The sql equivalent:
    # SELECT "questions".* FROM "questions" ORDER BY "qeustions"."id" DESC LIMIT 1;

    # .find
    # Question.find(1) 👈 finding records by their primary key which is likely id

    # .find_by_x 👈 x is the column name
    # Question.find_by_title('My Last Question') 👈 this finds a question with title 
    # exactly "My Last Question"

    # .where
    # Question.where({ title: 'My Last Question', body: 'The body of the question' })

    # WILDCARD SEARCHING 
    # You can perform  wildcard searching with ActiveRecord using LIKE within "where" method
    # Question.where(['title LIKE ?', '%Last%'])
    # if you are using Postgres client, you can use ILIKE for case-insensitive searching:
    # Question.where(['title ILIKE ?', '%Last%'])
    # Note that in above queries we used a syntax that used '?' to insert variable into a SQL query.
    # this is important to avoid SQL injection if the variable component is actually a user input such
    # as search term.

    # .limit
    # Question.limit(10) 👈 this will give us back 10 first questions that are returned from the query

    # .order
    # Question.order(:created_at) 👈 this will order the fetched records by created_at. by default is ASC and 
    # if you want them in descending order do:
    # Question.order(created_at: :DESC)


    # Chaining
    # You can chain the wher, limit, order, offset, and many others to compose
    # more sophisticated queries for example:
    # Question.where(['view_count > ?', 10]).where(['title ILIKE ?', 'a']).order(id: :DESC).limit(10).offset(10)
    # Note: offset will skip first 10 records from the above query
    # SQL equivalent:
    # SELECT "questions".* FROM "questions" WHERE (view_count > 10) AND (title ILIKE 'a') ORDER BY id DESC LIMIT 10 OFFSET 10
    # another example:
    # Question.where(['view_count < ?', 10]).where(['body ILIKE ?', '%question%']).order(id: :DESC).limit(1).offset(1)

    # UPDATE RECORDS
    # once you've selected one or more records, you have ability to update them
    # Many setting attributes:
    # q = Question.find 10
    # q.title = "Some new title"
    # q.save
    # q.view_count += 1
    # q.save

    # using .update_attributes or .update
    # q = Question.find 10
    # q.update({ title: 'Updated Title', body: 'Updated body' }) or
    # q.update_attribute(:title, 'Updated Title') or
    # q.update_attributes(title: 'Updated Title', body: 'Updated body')

    # DELETING RECORDS
    # using .destroy
    # q = Question.find 10
    # q.destroy

    # using .delete
    # q = Question.find 10
    # q.delete

    # using .delete skips executing callback methods after_destroy and before_destroy 
    # and also skips deleting or nullifying associated records in the :dependant option
    # with associtations. Generally, avoid using ".delete" in favor of ".destroy". there are
    # only few cases when you want to use ".delete"

    # Aggregate functions
    # .count
    # Question.count 👈 counts the number of records in questions model
    # SQL equivalent:
    # SELECT COUNT(*) FROM "questions";

    # .groud
    # Question.select('avg(view_count)) as count').group('title')

end
