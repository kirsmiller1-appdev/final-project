# == Schema Information
#
# Table name: inventories
#
#  id         :integer          not null, primary key
#  end_date   :date
#  location   :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :integer
#  wine_id    :integer
#

class Inventory < ApplicationRecord
  belongs_to :owner, :class_name => "User"
  belongs_to :wine
  
  validates :wine_id, :presence => true
  validates :owner_id, :presence => true
  validates :location, :presence => true

  def owner_name
    owner = User.where({ :id => owner_id }).at(0)
    name = owner.first_name
    return name
  end

  def vintage
      wine = Wine.where({ :id => wine_id }).at(0)
      vintage = wine.vintage
      return vintage
  end

  def vineyard
    wine = Wine.where({ :id => wine_id }).at(0)
    vineyard = wine.vineyard
    return vineyard
  end

  def blend
    wine = Wine.where({ :id => wine_id }).at(0)
    blend = wine.blend
    return blend
  end

  def expert_rating
    wine = Wine.where({ :id => wine_id }).at(0)
    expert_rating = wine.expert_rating
    return expert_rating
  end

  def expert_notes
    wine = Wine.where({ :id => wine_id }).at(0)
    expert_notes = wine.expert_notes
    return expert_notes
  end

  def external_url
    wine = Wine.where({ :id => wine_id }).at(0)
    external_url = wine.external_url
    return external_url
  end

  def photo_url
    wine = Wine.where({ :id => wine_id }).at(0)
    photo_url = wine.photo_url
    return photo_url
  end

  def tags
    tags_array = Tag.where({ :wine_id => wine_id }).all
    tags = tags_array.pluck(:tag)
    return tags
  end

  def tags_array
    tags_array = Tag.where({ :wine_id => wine_id })
    return tags_array
  end

  def alive
    if end_date == nil
      return true
    else 
      return false
    end
  end

  def avg_rating
    ratings = UserRating.where({ :wine_id => self.wine_id }).pluck(:rating)
    if ratings.size.to_f == 0
      avg_rating = 0
    else
      avg_rating = ratings.reduce(:+) / ratings.size.to_f
    end
    return avg_rating.round(1)
  end

  def comments_array
    comments = UserComment.where({ :wine_id => self.wine_id }).all
    return comments
  end
end
