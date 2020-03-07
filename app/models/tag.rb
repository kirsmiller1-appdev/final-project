# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  tag        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  wine_id    :integer
#

class Tag < ApplicationRecord
  belongs_to :tagger, :class_name => "User", :foreign_key => "user_id"
  belongs_to :tagged_wine, :class_name => "Wine", :foreign_key => "wine_id"

  validates :wine_id, :presence => true
  validates :user_id, :presence => true
end
