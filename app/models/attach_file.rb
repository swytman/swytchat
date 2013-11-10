# == Schema Information
#
# Table name: attach_files
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  room_id           :integer
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime
#  updated_at        :datetime
#

class AttachFile < ActiveRecord::Base

attr_accessible :file

has_attached_file :file
belongs_to :user
belongs_to :room

validates :file, :attachment_presence => true
  
end
