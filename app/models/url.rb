class Url < ActiveRecord::Base
  validates :url, format: { with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/, 
                            message: "Need Valid URL"} 
  has_many :user_url
  has_many :users, :through => :user_url
end
