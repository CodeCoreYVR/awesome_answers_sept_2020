class HelloWorldJob < ApplicationJob
  queue_as :default

  def perform(word) # this contains all the code that will run at a later point in time
    puts "------------"
    puts "Running a job 🏃‍♀️"
    puts "The word is: #{word}"
    puts "------------"
  end
end
# To run this job... inside of a Controller (or Model)
# <JobClass>.perform_now()

#Example:
# Inside of the Answers Controller:
# HelloWorldJob.perform_now("blueberries")
# HelloWorldJob.perform_later("black berries") # .perform_later will put this job in the Queue to be done at a later point in time