User.delete_all
Question.delete_all
Answer.delete_all
Comment.delete_all
Vote.delete_all

users = []
5.times {users << User.create!(
						username: Faker::Internet.user_name(Faker::HarryPotter.character),
						email: Faker::Internet.free_email,
						password: "password",
						profile_url: "https://robohash.org/#{rand(5)}?set=set3")}

5.times {users << User.create!(
						username: Faker::Internet.user_name(Faker::LordOfTheRings.character),
						email: Faker::Internet.free_email,
						password: "password",
						profile_url: "https://robohash.org/#{rand(5)}")}

5.times {users << User.create!(
						username: Faker::Internet.user_name(Faker::StarWars.character),
						email: Faker::Internet.free_email,
						password: "password",
						profile_url: "https://robohash.org/#{rand(5)}?set=set2")}


questions = []
20.times {questions << Question.create!(
						title: Faker::TwinPeaks.quote,
						description: Faker::Hipster.paragraph,
						author_id: users.sample.id)}

answers = []
50.times { answers << Answer.create!(
						description: Faker::Hacker.say_something_smart,
						author_id: rand(1..15),
						question_id: rand(1..20))}

questions.each do |question|
	question.best_answer = rand(1..50)
	question.save
end

comments = []
50.times {comments << Comment.create!(
						commentable: questions.sample,
						description: Faker::ChuckNorris.fact,
						author_id: rand(1..15))}
50.times {comments << Comment.create!(
						commentable: answers.sample,
						description: Faker::ChuckNorris.fact,
						author_id: rand(1..15))}

120.times {Vote.create(
						votable: questions.sample,
						user_id: rand(1..15),
						value: [1, 1, 1, -1].sample)}
120.times {Vote.create(
						votable: answers.sample,
						user_id: rand(1..15),
						value: [1, 1, 1, -1].sample)}
120.times {Vote.create(
						votable: comments.sample,
						user_id: rand(1..15),
						value: [1, 1, 1, -1].sample)}
