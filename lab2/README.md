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

Finally, the index page should look something like this, with all the orders listed and the counters in place:

![img](https://github.com/taurrielle/IPP/blob/master/imgs/2.png)


3. **Composite**

The intent of the Composite pattern is to compose objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly. For this pattern I tried to simulate how the room service works. We have tasks that are to be executed in order to compete the order. So, I created the base class called `BaseTask`.

```ruby
class Services::Tasks::BaseTask
  attr_reader :name

  def initialize(name, room, order)
    @name = name
    @room = room
    @order = order
  end

  def execute_task
    puts @name + " for room ##{@room}\n"
  end
end
```
It is initialized with a name, room and order and it is executed by simply printing something in the console. Besides this base class, I also have two child classes: `CookTask` and `DeliveryTask`. 

```ruby
class Services::Tasks::CookTask < Services::Tasks::BaseTask
  def initialize(room, order)
    super('Cook food', room, order)
  end

  def get_time_required
    10
  end
end
```
Here, I initialize it and set a required time for the task to be executed. These tasks, as I said earlier, are needed to be executed in order for the order to be completed, so, naturally, they are called from the `RoomService` class. That's where the magic happens. In the `RoomService` class I execute both tasks and just output how much time, thoretically it would have taken to complete the order. Theoretically, this data can be used later on for statistics ad stuff like that. 

```ruby
def execute
  cook_task = Services::Tasks::CookTask.new(@data.room, @data.order)
  cook_task.execute_task
  delivery_task = Services::Tasks::DeliveryTask.new(@data.room, @data.order)
  delivery_task.execute_task
  puts "Order done in #{cook_task.get_time_required + delivery_task.get_time_required} minutes"
  @data.update_attributes(status: "DONE")
end
 ```

Granted, these small tasks can be used separately in another service. For example, the `DeliveryTask` can be used in the `LaundryService` to deliver the fresh clothes to the room.
