helpers do

	def current_user
  	@user ||= User.find_by(id: session[:user_id])
	end

	def currently_logged_in?
  	current_user ? true : false
	end

end
