class City < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_many :memories
end
