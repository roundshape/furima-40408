class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :ship_from_id, :city, :address, :building, :phone, :price

  with_options presence: true do
    validates :item_id, :user_id, :ship_from_id, :city, :address, :phone, :price
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'is invalid' }
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end
end
