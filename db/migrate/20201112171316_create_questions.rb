class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    # by its own it doesnothing
    #Migrations are incremental changes to a database
    #They can always be reversed
    #Migration are defined in migration files
    create_table :questions do |t| # Here questions represents table name and it is plural

      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
