user2 = User.create(username: "Frob", email: "Frob@dbc.com", hashed_password: "password")
user2.questions.create(title: "Question about stuff", description: "This is a question")
user = User.create(username: "Bob", email: "bob@dbc.com", hashed_password: "password")
q = Question.first
user.comments.create(description: "This is a comment", commentable: q)
users = []
5.times {users << User.create!(
						username: Faker::Internet.user_name(Faker::HarryPotter.character),
						email: Faker::Internet.free_email,
						hashed_password: "password"

	)}

5.times {users << User.create!(
						username: Faker::Internet.user_name(Faker::LordOfTheRings.character),
						email: Faker::Internet.free_email,
						hashed_password: "password"

	)}

5.times {users << User.create!(
						username: Faker::Internet.user_name(Faker::StarWars.character),
						email: Faker::Internet.free_email,
						hashed_password: "password"

	)}
puts users
questions = []
20.times {questions << Question.create!(
						title: Faker::TwinPeaks.quote, 
						description: Faker::Hipster.sentences, 
						author_id: users.sample.id
	)}

answers = []
50.times { answers << Answer.create!(
						description: Faker::Hacker.say_something_smart,
						author_id: rand(1..50),
						question_id: rand(1..50)
						)}

questions.map do |question| 
	question.best_answer = rand(1..50)
	question.save
end

comments = []
35.times {comments << Comment.create!(description: Faker::ChuckNorris.fact, author_id: rand(1..15))}


votes = []
60.times {votes << Vote.create!(
						user_id: rand(1..15),
						value: [1, -1].sample
						)}