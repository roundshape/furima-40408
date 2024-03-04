require 'rails_helper'

RSpec.describe PurchaseDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user: user)
    @purchase_delivery = FactoryBot.build(:purchase_delivery, user_id: user.id, item_id: item.id)
  end

  context '内容に問題ない場合' do
    it '入力項目が揃っていれば保存ができること' do
      expect(@purchase_delivery).to be_valid
    end

    it 'buildingが空でも保存ができること' do
      @purchase_delivery.building = ''
      expect(@purchase_delivery).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'tokenが空では登録できないこと' do
      @purchase_delivery.token = nil
      @purchase_delivery.valid?
      expect(@purchase_delivery.errors.full_messages).to include("Token can't be blank")
    end

    it 'post_codeが空では保存ができないこと' do
      @purchase_delivery.post_code = ''
      @purchase_delivery.valid?
      expect(@purchase_delivery.errors.full_messages).to include("Post code can't be blank")
    end

    it 'post_codeが4桁-3桁では保存ができないこと' do
      @purchase_delivery.post_code = '1234-123'
      @purchase_delivery.valid?
      expect(@purchase_delivery.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
    end

    it 'post_codeに-なしでは保存ができないこと' do
      @purchase_delivery.post_code = '1231234'
      @purchase_delivery.valid?
      expect(@purchase_delivery.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
    end

    it 'ship_from_idが1では保存ができないこと' do
      @purchase_delivery.ship_from_id = 1
      @purchase_delivery.valid?
      expect(@purchase_delivery.errors.full_messages).to include("Ship from can't be ---")
    end

    it 'cityが空では保存ができないこと' do
      @purchase_delivery.city = ''
      @purchase_delivery.valid?
      expect(@purchase_delivery.errors.full_messages).to include("City can't be blank")
    end

    it 'addressが空では保存ができないこと' do
      @purchase_delivery.address = ''
      @purchase_delivery.valid?
      expect(@purchase_delivery.errors.full_messages).to include("Address can't be blank")
    end

    it 'phoneが空では保存ができないこと' do
      @purchase_delivery.phone = ''
      @purchase_delivery.valid?
      expect(@purchase_delivery.errors.full_messages).to include("Phone can't be blank")
    end

    it 'phoneが9桁では保存ができないこと' do
      @purchase_delivery.phone = '123456789'
      @purchase_delivery.valid?
      expect(@purchase_delivery.errors.full_messages).to include("Phone is invalid")
    end

    it 'phoneが12桁では保存ができないこと' do
      @purchase_delivery.phone = '123456789012'
      @purchase_delivery.valid?
      expect(@purchase_delivery.errors.full_messages).to include("Phone is invalid")
    end
  end
end
