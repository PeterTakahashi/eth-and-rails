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
class User < ApplicationRecord
  # for this demo only eth address, nonce, and name is mandatory
  validates :eth_address, presence: true, uniqueness: true
  validates :eth_nonce, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
