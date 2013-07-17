helpers do
  def logged_in?
    !session[:user_id].nil?
  end

  def user_id
    session[:user_id]
  end
end


get '/' do
  if logged_in?
    @user = User.find(user_id)
    erb :secret
  else
    erb :index
  end
end

post '/new_user' do
  email = params[:email]
  password = params[:password]
  pw_hash = Digest::MD5.hexdigest(password)
  user = User.create({email: email, password_hash: pw_hash})
  session[:user_id] = user.id
  redirect to('/')
end

post '/login' do
  email = params[:email]
  password = params[:password]
  user = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
  end
  redirect to('/')
end

get '/logout' do
  session.clear
  redirect to('/')
end
