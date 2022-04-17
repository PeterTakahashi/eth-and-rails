# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  eth_address :string(255)
#  eth_nonce   :string(255)
#  username    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_eth_address  (eth_address) UNIQUE
#  index_users_on_eth_nonce    (eth_nonce) UNIQUE
#  index_users_on_username     (username) UNIQUE
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
