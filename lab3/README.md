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

