class Question < ApplicationRecord
# 👆🏻Question Class inherits from ApplicationRecord

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


end
