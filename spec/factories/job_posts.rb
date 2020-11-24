# rails g factory_bot:model job_post
# 👆🏻Used this terminal command to generate factory_bot
RANDOM_100_PLUS_CHARS= 'hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world!'

FactoryBot.define do
  factory :job_post do
    # All objects created by factories are valid data / object.
    sequence(:title){|n| Faker::Job.title + "#{n}"}
    # Sequence is a method provided by factory_bot which keeps injecting a variable n. n is usually a number that factory-bot increments on every object it generates. so we can use it to make sure all the instances createda re unique.
    
    description { Faker:: Job.field + "#{RANDOM_100_PLUS_CHARS}" }
    # In this case we are adding 100 character to the description of any job_post to make sure it passes a description validation.

    location {Faker::Address.city}
    min_salary{rand(80_000..200_000)}
    max_salary{rand(200_000..400_000)}
    
  end
end

# FactoryBot.create(:job_post)  👈🏻So this will create a object and save it in a database
# Factory.build(:job_post) 👈🏻 So this will give us an object like .new but will not save in database