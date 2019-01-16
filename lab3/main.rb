require "pry"
require './coffee.rb'
require './fancy_barista.rb'
require './waiter.rb'
require './coffee.rb'
require './external_iterator.rb'

class LifeCycle
  def initialize
    @menu = ['Coffee', 'CoffeeWithSugar', 'CoffeeWithCream', 'PumpkinSpiceLatte', 'Ristretto', 'Affogato', 'KopiLuwak']
    @barista = FancyBarista.new({
      'Coffee':            15,
      'CoffeeWithSugar':   10,
      'PumpkinSpiceLatte': 1,
      'Ristretto':         2,
      'Affogato':          3,
      'KopiLuwak':         1
    })
    @waiter = Waiter.new(
      @menu,
      @barista,
      ['CoffeeWithCream']
    )

    @barista.add_observer(@waiter)
  end

  def start
    waiting_for_client = false
    @waiter.greet_customers

    loop do
      unless waiting_for_client
        Thread.new do
          puts "What is your order?"
          order = gets.chomp
          @waiter.handle(order)
          waiting_for_client = false if order
        end
        waiting_for_client = true
      end

      unless @barista.finished_orders.empty?
        @barista.finished_orders.each do |order|
          @waiter.serve(order)
        end
        @barista.finished_orders = []

        @waiter.unavailable_items
        waiting_for_client = false
      end
    end
  end
end

LifeCycle.new.start