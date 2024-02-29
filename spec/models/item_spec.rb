require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できる場合' do
      it '全ての項目が入力されていれば保存できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できない場合' do
      it 'categoryが---では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be ---")
      end
      it 'nameが空の場合保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'detailが空の場合保存できない' do
        @item.detail = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail can't be blank")
      end
      it 'priceが空の場合保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'conditionが---では保存できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be ---")
      end
      it 'ship_respが---では保存できない' do
        @item.ship_resp_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship resp can't be ---")
      end
      it 'ship_fromが---では保存できない' do
        @item.ship_from_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship from can't be ---")
      end
      it 'ship_periodが---では保存できない' do
        @item.ship_period_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship period can't be ---")
      end
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
