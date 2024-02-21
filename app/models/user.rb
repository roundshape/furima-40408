class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'is invalid' }
  validates :nickname, :first_name, :last_name,
            :first_kana, :last_kana, :birthday, presence: true
  validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'is invalid' }
  validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'is invalid' }
  validates :first_kana, format: { with: /\A[\p{katakana}ー－]+\z/, message: 'is invalid' }
  validates :last_kana, format: { with: /\A[\p{katakana}ー－]+\z/, message: 'is invalid' }
end
