class OrderHistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index]
  before_action :move_to_index_if_seller, only: [:index]

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_history_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_history_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).price,
      card: order_history_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    return unless current_user == @item.user

    redirect_to root_path
  end

  def move_to_index_if_seller
    return unless user_signed_in? && current_user.id != @item.user_id && @item.sold_out?

    redirect_to root_path
  end
end
