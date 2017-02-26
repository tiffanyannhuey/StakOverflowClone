get '/inspect' do 
  session.inspect
end 

get '/login' do
  if request.xhr? 
    erb :'login', layout: false
  else
    erb :'login'
  end
end 

post '/login' do 
  user = User.find_by(email: params[:user][:email])
  if user && user.authenticate(params[:user][:password])
    status 200
    session[:user_id] = user.id
    if request.xhr?
      erb :'index'
    else
      redirect "/users/#{user.id}"
    end  
  else  
    status 422
    @error = "Invalid login. Please enter your credentials."
    if request.xhr?
      @error.to_s
    else  
      erb :'login'
    end
  end

end

get '/logout' do 
  session[:user_id] = nil
  redirect '/'
end