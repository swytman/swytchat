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

require 'spec_helper'

describe AttachFile do
  pending "add some examples to (or delete) #{__FILE__}"
end
