require 'singleton'

class Pizza
  attr_reader :name, :toppings, :state

  def initialize(name, toppings)
    @name = name
    @toppings = toppings
    @state = 'raw'
  end

  def bake
    puts "Baking #{name} ..."
    sleep 2
    state = 'baked'
    puts "Pizza #{name} baked"
  end
end

class Sommelier
  def initialize(wine_type)
    @wine_type = wine_type
  end

  def serve!
    @wine_type.serve
  end
end

class RedWine
  def serve
    puts "Red wine is served"
  end
end

class WhiteWine
  def serve
    puts "White wine is served"
  end
end

class PizzaStore
  include Singleton
  attr_accessor :pizza_prototype_collection

  def initialize
    @pizza_prototype_collection = {}
  end

  def take_pizza_order(pizza_type)
    pizza_prototype = pizza_prototype_collection[pizza_type]
    raise 'unsupported pizza type' unless pizza_prototype

    pizza = pizza_prototype.clone
    pizza.bake
    pizza
  end

  def take_wine_order(wine_type)
    Sommelier.new(wine_type).serve!
  end
end