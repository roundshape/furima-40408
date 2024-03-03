class PurchasesController < ApplicationController
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params.except(:post_code, :ship_from_id, :city, :address, :building, :phone))
    @delivery = @purchase.build_delivery(delivery_params)
    if @purchase.valid? && @delivery.valid?
      pay_item
      @purchase.save
      @delivery.save
      redirect_to root_path
    else
      # renderメソッドはturbo:loadが発火しない
      # gonを使用すると代わりにturbo:renderが発火するので
      # javascript側で以下の２行が必要
      # window.addEventListener("turbo:load", pay);
      # window.addEventListener("turbo:render", pay);
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:token, :item_id, :user_id, delivery_attributes: [:post_code, :ship_from_id, :city, :address, :building, :phone])
  end

  def delivery_params
    params.require(:purchase).permit(:post_code, :ship_from_id, :city, :address, :building, :phone)
  end

  def pay_item
    item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: item.price, # 商品の値段
      card: params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
