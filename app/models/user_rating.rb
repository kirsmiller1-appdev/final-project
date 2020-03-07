# == Schema Information
#
# Table name: user_ratings
#
#  id         :integer          not null, primary key
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  wine_id    :integer
#

class UserRating < ApplicationRecord
  belongs_to :rater, :class_name => "User", :foreign_key => "user_id"
  belongs_to :rated_wine, :class_name => "Wine", :foreign_key => "wine_id"
  validates :wine_id, :presence => true
  validates :user_id, :presence => true
end
