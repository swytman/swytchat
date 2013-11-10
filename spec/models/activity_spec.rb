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

require 'spec_helper'

describe Activity do
  pending "add some examples to (or delete) #{__FILE__}"
end
