class Message < ActiveRecord::Base
attr_accessible :content
default_scope order: 'messages.created_at DESC'

validates :user_id, presence: true
validates :room_id, presence: true

belongs_to :user
belongs_to :room


end
