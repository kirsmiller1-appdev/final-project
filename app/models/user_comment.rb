# == Schema Information
#
# Table name: user_comments
#
#  id         :integer          not null, primary key
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  wine_id    :integer
#

class UserComment < ApplicationRecord
  belongs_to :commenter, :class_name => "User", :foreign_key => "user_id"
  belongs_to :commented_wine, :class_name => "Wine", :foreign_key => "wine_id"
  validates :wine_id, :presence => true
  validates :user_id, :presence => true

  def commenter_name
    commenter = User.where({ :id => user_id }).at(0)
    name = commenter.first_name
    return name
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
