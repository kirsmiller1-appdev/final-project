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
end
