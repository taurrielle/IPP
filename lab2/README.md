In this laboratory work I used three creational design patterns: command, facade and composite. I developed a Rails application where the staff of a hotel can input the cients' orders and automatically sends these orders to the specified departments that need to take care of the order (for example the kitchen). 

1. **Command**

As I said earlier, in this app we the hotel's staff can create orders by completing a form. 
![img](https://github.com/taurrielle/IPP/blob/master/imgs/1.png)

Then, the order is created by this method: 
``` ruby
def create
  order = Order.create(order_params)
  service = "Services::#{order_params["service"]}".constantize.new(order)
  ConciergeWorker.instance.request_list << service
  redirect_to root_path
end
```
Here, I instantiate a new object of the selected service, which can be `RoomService`, `LaundryService` or `TripPlanningService` and append this service object to the request_list of the `ConciergeWorker` that will process it later on. Also, I would like to point out that the `ConciergeWorker` class is a Singleton (do I get extra points for that? :D). 

Next, I have a scheduler that calls the `acts_on_requests` method of the `ConciergeWorker` class every 20 seconds. 
```ruby
scheduler.every '20s' do
  ConciergeWorker.instance.act_on_requests
end
```

This method is as simple as can be. It just calls the execute method for every object in the `request_list` and it works because every service class has this method defined. 
```ruby 
def act_on_requests
  return if @request_list.empty?
  @request_list.each do |request|
    request.execute
  end
  @request_list = []
end
```

So, with this method I distribute the responsibility and knowledge back to each request and let it decide how to handle itself, thus decoupling the command from when and where it is sent.

2. **Facade**

The Facade pattern provides a unified interface to a set of interfaces in a subsystem. Facade defines a higher-level interface that makes the subsystem easier to use. So that's what I did to simplify a the `Orders` controller, I used Facade to remove the responsibility of preparing data for the view and create unified face visible to outside world. I created a `OrdersFacade` class that will handle all the data preparations. 

```ruby
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
```
This facade class gathers all the information I need in the view, like all hte orders, their number, the number of pending orders and the number of completed orders. So, I just initialize this class in the index method of the controller:

```ruby
@order_facade = OrdersFacade.new
```

and use it in the view like this:
```ruby
<%= @order_facade.all_orders_nr %>
```




