class AddViewCountToQuestions < ActiveRecord::Migration[6.0]
  # rails g migration AddViewCountToQuestions
  # This migration was generated using above terminal command
  # Migration name has datetime stamp and name of the migration given by us in a snake_case

##Here are all the Rails 4 (ActiveRecord migration) datatypes:

# -   `:binary`
# -   `:boolean`
# -   `:date`
# -   `:datetime`
# -   `:decimal`
# -   `:float`
# -   `:integer`
# -   `:bigint`
# -   `:primary_key`
# -   `:references`
# -   `:string`
# -   `:text`
# -   `:time`
# -   `:timestamp`
  def change
    add_column :questions, :view_count, :integer
    # add_column takes three arguments 
    # 1. is a table name -> ":questions"
    # 2. is a column name -> ":view_count"
    # 3. is a datatype -> ":integer"
  end
end
