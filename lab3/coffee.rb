class Coffee
  attr_accessor :price

  def price
    2.50
  end
end

class CoffeeWithCream
  def initialize(coffee)
    @coffee = coffee
  end

  def price
    @coffee.price += 0.50
  end
end

class CoffeeWithSugar
  def initialize(coffee)
    @coffee = coffee
  end

  def price
    @coffee.price += 0.25
  end
end

# coffee = Coffee.new
# coffee = CoffeeWithCream.new(coffee)
# coffee = CoffeeWithSugar.new(coffee)

class PumpkinSpiceLatte
  attr_accessor :name, :price
  def initialize
    @name = "Pumpkin Spice Latte"
    @price = 4.50
  end
end

class Ristretto
  attr_accessor :name, :price
  def initialize
    @name = "Ristretto"
    @price = 5.50
  end
end

class Affogato
  attr_accessor :name, :price
  def initialize
    @name = "Affogato"
    @price = 5.0
  end
end

class KopiLuwak
  attr_accessor :name, :price
  def initialize
    @name = "Kopi Luwak"
    @price = 7.50
  end
end