class User < ActiveRecord::Base
  has_many :user_cities
  has_many :cities, through: :user_cities
  has_secure_password

  def slug
    username.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug }
  end
end
