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
end
