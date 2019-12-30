class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  has_one :payjp_customer, dependent: :destroy
  accepts_nested_attributes_for :authentications
end
