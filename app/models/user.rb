# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  string              :string(255)
#  email               :string(255)
#  password_digest     :string(255)
#  remember_token      :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class User < ActiveRecord::Base
attr_accessible :name, :email, :password, :password_confirmation, :change_password
has_attached_file :avatar,
:styles => { :medium => "200x200>", :thumb => "40x40>" },
:default_url => "/images/:style/default_avatar.png"

validates_attachment :avatar, :content_type => {:content_type => /image/ },
:size => {:in => 0..500.kilobytes }


has_secure_password
before_save { email.downcase! }
before_save :create_remember_token

validates :name, presence: true, length: { maximum: 50 },
					uniqueness: { case_sensitive: true }
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence:   true,
                  format:     { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }
validates :password, presence: true, length: { minimum: 6 }, :if => :change_password?
validates :password_confirmation, presence: true, :if => :change_password?


has_many :messages
has_many :rooms
has_many :activities, foreign_key: "user_id"
has_many :attach_file, foreign_key: "user_id"

def change_password=(ch)
    	@change_password = ch
 end


#PRIVATE
private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    

    def change_password?
    	@change_password
    end




end
