require "pry"

class LifeCycle
  def initialize(waiter, barista)
    @waiter = waiter
    @barista = barista
  end

  def start
    orders = []
    barista_table = []
    waiting_for_client_thinking = false

    loop do

      unless waiting_for_client_thinking
        Thread.new do
          puts "What is your order?"
          orders << gets.chomp
        end
        waiting_for_client_thinking = true
      end

      unless orders.empty?
        orders.each do |order|
          Thread.new do
            @waiter.put_order(order)
          end
          orders = []
        end
      end

      unless barista_table.empty?
        @waiter.give_smth_to_user # puts "espresso"
        #delete espresso form barista_table
      end
      # print "."
    end
  end
end

LifeCycle.new("bla", "tla").start