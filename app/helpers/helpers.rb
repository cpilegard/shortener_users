helpers do
  def logged_in?
    !session[:user_id].nil?
  end

  def user_id
    session[:user_id].to_i
  end
end
