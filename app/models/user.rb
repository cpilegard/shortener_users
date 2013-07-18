class User < ActiveRecord::Base
  validates :email, :password_hash, presence: true
  has_many :user_url
  has_many :urls, :through => :user_url

  def self.authenticate(email, password)
    user = User.where(email: email, password_hash: encrypted_password(password)).first
    unless user == nil
      return user
    else
      return nil
    end
  end

  def self.encrypted_password(password)
    Digest::MD5.hexdigest(password)
  end
end
