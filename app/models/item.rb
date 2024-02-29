class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :ship_from
  belongs_to :ship_period
  belongs_to :ship_resp
  belongs_to :user
  has_one_attached :image

  validates :category_id, :name, :detail,
            :condition_id, :ship_resp_id,
            :ship_from_id, :ship_period_id, presence: true
  validates :image, presence: true

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  # カスタムバリデーションの追加
  validate :category_cannot_be_default
  validate :condition_cannot_be_default
  validate :ship_resp_cannot_be_default
  validate :ship_from_cannot_be_default
  validate :ship_period_cannot_be_default

  private

  def category_cannot_be_default
    return unless category_id == 1

    errors.add(:category_id, "can't be ---")
  end

  def condition_cannot_be_default
    return unless condition_id == 1

    errors.add(:condition_id, "can't be ---")
  end

  def ship_resp_cannot_be_default
    return unless ship_resp_id == 1

    errors.add(:ship_resp_id, "can't be ---")
  end

  def ship_from_cannot_be_default
    return unless ship_from_id == 1

    errors.add(:ship_from_id, "can't be ---")
  end

  def ship_period_cannot_be_default
    return unless ship_period_id == 1

    errors.add(:ship_period_id, "can't be ---")
  end
end
