# == Schema Information
#
# Table name: rooms
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  no_pass         :boolean          default(FALSE)
#  salt            :string(255)
#  remember_token  :string(255)
#  users           :text
#  user_id         :integer
#

class Room < ActiveRecord::Base

  attr_accessible :name, :password, :password_confirmation

  has_secure_password :validations => false

belongs_to :user

has_many :messages, dependent: :destroy

  validates :password, presence: true, confirmation: true, :if => :setting_password?
  validates :password_confirmation, presence: true        , :if => :setting_password?

  validates :name, length: { maximum: 50 }, presence: true,
					uniqueness: {case_sensitive: false}
 has_many :activities, foreign_key: "room_id", dependent: :destroy
 has_many :attach_file, foreign_key: "room_id", dependent: :destroy
 has_many :active_users, :through => :activities

##def authenticate(password)
 ##   password.present? && password_digest.present? && password_digest == BCrypt::Engine.hash_secret(password, password_salt)
##end

#def no_pass?
 #    if password=""
  #   	no_pass=true
  #   end
  #end



private

   
def setting_password?
    password.present? || password_confirmation.present?
end





end
