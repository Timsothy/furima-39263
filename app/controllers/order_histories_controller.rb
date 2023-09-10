class OrderHistoriesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new
  end

  def create
    @order_history = OrderHistory.create(order_history_params)
    ShippingAddress.create(shipping_address_params)
    redirect_to root_path
  end

  private

  def order_history_params
    params.require(:order_history).marge(:item, :user)
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:postal_code, :city, :addresses, :building, :phone_number).marge(:prefecture_id)
  end
end
