class OrdersFacade
  def all_orders
    @all_orders ||= Order.all.reverse
  end

  def all_orders_nr
    @all_orders_nr ||= all_orders.count
  end

  def pending_orders_nr
    @pending_orders_nr ||= Order.where(status: "PENDING").count
  end

  def done_orders_nr
    @done_orders_nr ||= Order.where(status: "DONE").count
  end
end