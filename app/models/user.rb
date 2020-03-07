# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  location        :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_many :comments, :class_name => "UserComment", :dependent => :destroy
  has_many :ratings, :class_name => "UserRating", :dependent => :destroy
  has_many :owned_wines, :class_name => "Inventory", :foreign_key => "owner_id", :dependent => :destroy
  has_many :tags, :dependent => :destroy
  has_many :sent_follow_requests, :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy
  has_many :received_follow_requests, :class_name => "FollowRequest", :foreign_key => "leader_id", :dependent => :destroy

  has_many :leaders, :through => :sent_follow_requests, :source => :leader
  has_many :followers, :through => :received_follow_requests, :source => :sender

  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  validates :username, :presence => true
  validates :username, :uniqueness => true
  validates :location, :presence => true
  validates :first_name, :presence => true
end
