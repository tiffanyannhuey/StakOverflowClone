user2 = User.create(username: "Frob", email: "Frob@dbc.com", hashed_password: "password")
user2.questions.create(description: "This is a question")
user = User.create(username: "Bob", email: "bob@dbc.com", hashed_password: "password")
q = Question.first
user.comments.create(description: "This is a comment", commentable: q)
