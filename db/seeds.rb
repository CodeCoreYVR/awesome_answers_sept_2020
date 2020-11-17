# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# rail db:seed 👈🏻 command to run seed file
Question.destroy_all

200.times do
    # 👇🏻This will generate Random date in the past(Up to maximum of N days)
    created_at = Faker::Date.backward(days:365*5)

    Question.create(
        title: Faker::Hacker.say_something_smart,
        body: Faker::ChuckNorris.fact,
        view_count: rand(100_000),
        created_at:created_at,
        updated_at:created_at

    )

end
questions = Question.all

questions.each do |q|
    5.times do
        Answer.create(
            body: Faker::Lorem.paragraph,
            question_id: q.id
        )
    end
end

answers = Answer.all

puts Cowsay.say("Generated #{questions.count} questions", :frogs)
puts Cowsay.say("Generated #{answers.count} answers", :frogs)