# == Schema Information
#
# Table name: wines
#
#  id            :integer          not null, primary key
#  blend         :string
#  expert_notes  :text
#  expert_rating :float
#  external_url  :string
#  photo_url     :string
#  vineyard      :string
#  vintage       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Wine < ApplicationRecord

  has_many :owned_wines, :class_name => "Inventory", :dependent => :nullify
  has_many :user_comments, :dependent => :destroy
  has_many :user_ratings, :dependent => :destroy
  has_many :tags, :dependent => :destroy

  validates :vintage, :length => { :minimum => 4, :maximum => 4 }
  validates :vintage, :numericality => { :less_than => 2100, :greater_than => 1970 }
  validates :vintage, :presence => true
  validates :vineyard, :presence => true
  validates :blend, :presence => true

  def avg_rating
    ratings = UserRating.where({ :wine_id => self.id }).pluck(:rating)
    if ratings.size.to_f == 0
      avg_rating = 0
    else
      avg_rating = ratings.reduce(:+) / ratings.size.to_f
    end
    return avg_rating.round(1)
  end

    def tags
    tags_array = Tag.where({ :wine_id => self.id }).all
    tags = tags_array.pluck(:tag)
    return tags
  end

  def tags_array
    tags_array = Tag.where({ :wine_id => self.id })
    return tags_array
  end

  def comments_array
    comments_array = UserComment.where({ :wine_id => self.id })
    return comments_array
  end

  def available
    inventory_list = Inventory.where({ :wine_id => self.id }).all
    inventory_end_date = inventory_list.pluck(:end_date)
    available = inventory_end_date.any?{ |dates| dates.nil? }
    return available
  end

end
