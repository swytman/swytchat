# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  room_id    :integer
#  user_id    :integer
#  time       :datetime
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

class Activity < ActiveRecord::Base
attr_accessible :name, :room_id, :user_id, :time


end
