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
end
