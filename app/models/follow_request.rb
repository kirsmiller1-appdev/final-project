# == Schema Information
#
# Table name: follow_requests
#
#  id         :integer          not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  leader_id  :integer
#  sender_id  :integer
#

class FollowRequest < ApplicationRecord

  belongs_to :sender, :class_name => "User"
  belongs_to :leader, :class_name => "User"
  
end
