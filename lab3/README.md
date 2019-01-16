In this laboratory work I created a Ruby application using 4 patters: Proxy, Iterator, Observer and Decorator. This application simulates the work of a coffee shop (yes, again me and food) with a very fancy barista that does not bother to get the orders himself, he needs a personal waiter to do it or him. The waiter communicates with the clients on behalf of the barista and the barista's only job is to make the coffe and to notify the waiter that some bevarage is unavailable at the moment.


1. **Iterator**

The Iterator pattern enables the iteration over objects stored within an aggregate object. For the sake of this laboratory I implemented my own custom iterator, even though, I could have just as easily used Ruby's already implemented internal iterator: each. For this, I created a class called ExternalIterator which has two methods: next and has_next? and I used this class in order to enumerate the items in the menu:

```
def greet_customers
  puts "Welcome to our overpriced, fancy coffee shop!\n\n"
  puts "The menu:\n"
  array_iterator = ExternalIterator.new(@menu)

  while array_iterator.has_next?
    puts array_iterator.next + "\n"
  end
  puts "\n\n"
end
```

2. **Decorator**

The Decorator pattern allows us to add behavior to a given object without having to add that behavior to the class of the object. This gives us the ability to decorate objects with additional behavior for use within a specific context. The class I decided to "decorate" is my Coffee class. 

```
class Coffee
  attr_accessor :making_time, :name

  def initialize
    @name = "Coffee"
  end

  def making_time
    2 #minutes
  end
end
```

The first class to decorate is called CoffeeWithCream. The class accepts a coffee object. The coffee object is the component that is to be 'enclosed' by this decorator. I also added additional behavior to the making_time method of the coffee component by adding to it the making_time of coffee with cream.

```
class CoffeeWithCream
  attr_accessor :making_time, :name

  def initialize
    @coffee = Coffee.new
    @name   = "Coffee with cream"
  end

  def making_time
    @coffee.making_time += 1 #minutes
  end
end
```

3. **Proxy**

As I said above, the waiter basically acts as a proxy between the clients and the barista. It is the waiter who processed the orders and tells the clients that an item is unavailable or that it does not exist in general. All of this is done using the handle method from the waiter class:

```
def handle(order)
  return puts "Sorry, we don't serve #{order}\n\n" unless menu.include? order

  if @unavailable_items.include? order
    return puts "Sorry, the item you ordered is unavailable\n\n"
  end

  puts "Your order will be: #{order}\n\n"
  barista.take_order(Object.const_get(order).new)
end
```

What basically happens here, is that the waiter checks if the item requested by the client is in the actual menu, then check if the item is available and then send the order to the barista.


4. **Observer**

I used the observer pattern with the FancyBarista and the Waiter classes. The FancyBarista class is initialized with an array of observers that can be updated later on using the `add_observer` method. It is also initialized with an orders_capacity hash that contains the information about how many beverages of each type the barista can make. So, when he takes the order, he subtracts that quantity by 1 and if the quantity is equl to zero he notifies all the observers of the fact that there will be no more orders with that type of beverage.

```
def take_order(order)
  Thread.new do
    name = order.class.to_s
    orders_capacity[name.to_sym] = orders_capacity[name.to_sym] - 1
    notify_observers(name) if orders_capacity[name.to_sym] == 0

    sleep order.making_time
    @finished_orders << order
  end
end
```
\# yes, I used threads to make the barista work faster, I'm that hardcore :D

And the notify_observers method looks like this:
```
def notify_observers(item)
  @observers.each do |observer|
    observer.update(item)
  end
end
```

And the update method in the waiter class looks like this:
```
def update(item)
  @unavailable_items << item
end
```
