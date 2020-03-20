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

  def rater_name
    rater = User.where({ :id => self.user_id}).at(0)
    rater_name = rater.fetch(:first_name)
    return rater_name
  end

    def wine_vintage
    wine = Wine.where({ :id => wine_id}).at(0)
    vintage = wine.fetch(:vintage)
    return vintage
  end

  def wine_vineyard
    wine = Wine.where({ :id => wine_id}).at(0)
    vineyard = wine.fetch(:vineyard)
    return vineyard
  end

  def wine_blend
    wine = Wine.where({ :id => wine_id}).at(0)
    blend = wine.fetch(:blend)
    return blend
  end
  
end
