class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @prototype = Prototype.find(params[:id])
  #   @prototype.destroy
  #   redirect_to root_path
  # end

  # def edit
  #   @prototype = Prototype.find(params[:id])
  #   if @prototype.user == current_user
  #     render :edit
  #   else
  #     redirect_to root_path
  #   end
  # end

  # def show
  #   @prototype = Prototype.find(params[:id])
  #   @comments = @prototype.comments.includes(:user)
  #   @comment = Comment.new # 新しいコメント用
  # end

  # def update
  #   @prototype = Prototype.find(params[:id])
  #   if @prototype.update(prototype_params)
  #     redirect_to prototype_path(@prototype)
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :price,
                                 :category_id, :condition_id,
                                 :ship_resp_id, :ship_from_id, :ship_period_id,
                                 :image).merge(user_id: current_user.id)
  end
end
