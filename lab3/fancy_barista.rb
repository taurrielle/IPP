class FancyBarista
  attr_accessor :finished_orders, :orders_capacity

  def initialize(orders_capacity)
    @observers       = []
    @finished_orders = []
    @orders_capacity = orders_capacity
  end

  def take_order(order)
    Thread.new do
      name = order.class.to_s
      orders_capacity[name.to_sym] = orders_capacity[name.to_sym] - 1
      notify_observers(name) if orders_capacity[name.to_sym] == 0

      sleep order.making_time
      @finished_orders << order
    end
  end

  def add_observer(observer)
    @observers << observer
  end

  def notify_observers(item)
    @observers.each do |observer|
      observer.update(item)
    end
  end
end