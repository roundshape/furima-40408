class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]

  def index
    redirect_to root_path and return if @item.purchase || @item.user_id == current_user.id

    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_delivery = PurchaseDelivery.new
  end

  def create
    @purchase_delivery = PurchaseDelivery.new(purchase_params)
    if @purchase_delivery.valid?
      if pay_item && @purchase_delivery.save
        redirect_to root_path and return
      else
        # 保存が失敗した場合はここで処理を行う
        gon.public_key = ENV['PAYJP_PUBLIC_KEY']
        render 'index', status: :unprocessable_entity and return
      end
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  # def purchase_params
  #   params.require(:purchase_delivery).permit(:token, :post_code, :ship_from_id, :city, :address, :building, :phone).merge(
  #     user_id: current_user.id, item_id: @item.id)
  # end
  def purchase_params
    params.require(:purchase_delivery).permit(:post_code, :ship_from_id, :city, :address, :building, :phone).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token])
  end
  
  def handle_payment_failure(_exception)
    # ここで支払い処理の失敗に関する処理を行います。
    # 例えば、エラーメッセージを設定したり、ログを記録したりします。
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    render 'index', status: :unprocessable_entity
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    begin
      Payjp::Charge.create(
        amount: @item.price,    # 商品の値段
        card: params[:token],   # カードトークン
        currency: 'jpy'         # 通貨の種類（日本円）
      )
      # ここに成功時の処理を書く
      # 例: 注文の状態を更新する、購入履歴を記録する、ユーザーに通知を送る等
      true
    rescue Payjp::CardError => e
      # カードエラーの場合の処理
      e.json_body[:error][:message]
      false
    rescue Payjp::PayjpError => e
      # その他のPAY.JP関連エラーの場合の処理
      e.json_body[:error][:message]
      false
    end
  end
end
