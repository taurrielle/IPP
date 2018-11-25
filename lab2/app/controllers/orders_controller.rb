class OrdersController < ApplicationController
  def index
    @order_facade = OrdersFacade.new
  end

  def new
    @order = Order.new
  end

  def create
    order = Order.create(order_params)
    service = "Services::#{order_params["service"]}".constantize.new(order)
    ConciergeWorker.instance.request_list << service
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit(:service, :room, :order)
  end
end
