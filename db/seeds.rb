# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# rail db:seed 👈🏻 command to run seed file
User.destroy_all
PASSWORD='supersecret'

super_user=User.create(
    first_name: 'Jon',
    last_name: 'Snow',
    email:"js@winterfell.gov",
    password: PASSWORD,
    is_admin: true
)
10.times do 
first_name=Faker::Name.first_name
last_name=Faker::Name.last_name
User.create(
    first_name:first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
)
end
users=User.all

Question.destroy_all

200.times do
    # 👇🏻This will generate Random date in the past(Up to maximum of N days)
    created_at = Faker::Date.backward(days:365*5)

    Question.create(
        title: Faker::Hacker.say_something_smart,
        body: Faker::ChuckNorris.fact,
        view_count: rand(100_000),
        created_at:created_at,
        updated_at:created_at,
        user: users.sample

    )

end
questions = Question.all

questions.each do |q|
    5.times do
        Answer.create(
            body: Faker::Lorem.paragraph,
            question_id: q.id,
            user: users.sample 
        )
    end
end

answers = Answer.all

puts Cowsay.say("Generated #{questions.count} questions", :frogs)
puts Cowsay.say("Generated #{answers.count} answers", :frogs)
puts Cowsay.say("Generated #{users.count} user", :beavis)
puts Cowsay.say("Login with #{super_user.email} and password: #{PASSWORD}", :koala)