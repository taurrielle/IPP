require './coffee.rb'
require './fancy_barista.rb'

class Waiter #the proxy
  attr_reader :menu, :barista, :unavailable_items

  def initialize(menu, barista, unavailable_items)
    @menu              = menu
    @barista           = barista
    @unavailable_items = unavailable_items
  end

  def handle(order)
    order.delete_if do |item|
      puts "Sorry, we cannot serve #{item.name}"
      unavailable_items.include? item
    end

    puts "Your order will be:\n"
    order.each do |item|
      puts "#{item}\n"
    end

    barista.take_order(order)
  end
end