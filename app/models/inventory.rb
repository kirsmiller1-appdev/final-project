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

  def tags
    tags_array = Tag.where({ :wine_id => wine_id })
    tags = tags_array.pluck(:tag)
    return tags
  end
end
