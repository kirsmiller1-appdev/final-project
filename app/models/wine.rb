# == Schema Information
#
# Table name: wines
#
#  id            :integer          not null, primary key
#  blend         :string
#  expert_notes  :text
#  expert_rating :integer
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
end
