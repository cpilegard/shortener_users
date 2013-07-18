get '/' do
  @short_url = params[:shortened]
  @errors = params[:error]
  if logged_in?
    @user = User.find(user_id)
    @links = @user.urls
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

post '/urls' do
  url = Url.create({ url: params[:long_url] })
  short_url = "http://localhost:9393/#{url.id}"
  if url.id
    if logged_in?
      User.find(user_id).urls << url
    end
    redirect to("/?shortened=#{short_url}")
  else
    redirect to("/?error=#{url.errors.first[1]}")
  end
end

# e.g., /q6bda
get '/:short_url' do
  id = params[:short_url].to_i
  redirect to(Url.find(id).url)
end
