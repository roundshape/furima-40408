class PurchaseDelivery
  include ActiveModel::Model

  attr_accessor :token, :item_id, :user_id, :post_code, :ship_from_id, :city, :address, :building, :phone

  with_options presence: true do
    validates :token, :item_id, :user_id, :ship_from_id, :city, :address
    validates :phone, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end
  validate :ship_from_cannot_be_default

  def save
    return false unless valid?

    purchase = Purchase.create(item_id:, user_id:)
    return unless purchase.persisted?

    delivery = Delivery.create(post_code:, ship_from_id:, city:, address:, building:, phone:, purchase:)
    return true if delivery.persisted?

    false
  end

  def ship_from_cannot_be_default
    return unless ship_from_id == '1' || ship_from_id == 1

    errors.add(:ship_from_id, "can't be ---")
  end
end
