class Delivery < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :ship_from
  belongs_to :purchase
end
