class OrderHistoriesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_history_params)
    if @order_form.valid?
      @order_form.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def order_history_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
  end
end
