class AttachFile < ActiveRecord::Base

attr_accessible :file

has_attached_file :file
belongs_to :user
belongs_to :room

  
end
