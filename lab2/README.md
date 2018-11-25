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


