require './coffee.rb'
require './external_iterator.rb'

class Waiter #the proxy
  attr_accessor :menu, :barista, :unavailable_items

  def initialize(menu, barista, unavailable_items)
    @menu              = menu
    @barista           = barista
    @unavailable_items = unavailable_items
  end

  def greet_customers
    puts "Welcome to our overpriced, fancy coffee shop!\n\n"
    puts "The menu:\n"
    array_iterator = ExternalIterator.new(@menu)

    while array_iterator.has_next?
      puts array_iterator.next + "\n"
    end
    puts "\n\n"
  end

  def handle(order)
    return puts "Sorry, we don't serve #{order}\n\n" unless menu.include? order

    if @unavailable_items.include? order
      return puts "Sorry, the item you ordered is unavailable\n\n"
    end

    puts "Your order will be: #{order}\n\n"
    barista.take_order(Object.const_get(order).new)
  end

  def serve(order)
    puts "\n##################\n"
    puts "#{order.name} is served\n\n"
    puts "\n##################\n"
  end

  def update(item)
    @unavailable_items << item
  end
end