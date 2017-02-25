get '/inspect' do 
  session.inspect
end 

get '/login' do 
  erb :'login'
end 

 post '/login' do 
  user = User.find_by(email: params[:user][:email])
  if user && user.authenticate(params[:user][:password])
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @error = "Invalid login. Please enter your credentials."
    erb :'login'
  end
end

get '/logout' do 
  session[:user_id] = nil
  redirect 'login'
end