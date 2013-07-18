class UserUrl < ActiveRecord::Base
  validates :user_id, :url_id, presence: true
  belongs_to :url
  belongs_to :user
end
