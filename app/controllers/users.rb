get '/users/new' do 
  erb :'users/new'
end 

post '/users/new' do
  @user = User.new(params[:user])
  if @user.valid? 
    @user.save
    redirect to "/login"
  else
    @errors = @user.errors.full_messages
    erb :"users/new"
  end
  
end