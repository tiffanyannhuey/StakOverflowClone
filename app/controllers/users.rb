get '/users/new' do
  erb :'users/new'
end

post '/users/new' do
  @user = User.new(params[:user])
  @user.profile_url = "https://robohash.org/#{rand(5)}?set=set3"
  if @user.valid?
    @user.save
    redirect to "/login"
  else
    @errors = @user.errors.full_messages
    erb :"users/new"
  end

end


get '/users/:id' do
  @user = User.find(params[:id])
erb :'/users/show'
end
