class Coffee
  attr_accessor :making_time, :name

  def initialize
    @name = "Coffee"
  end

  def making_time
    2 #minutes
  end
end

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

class CoffeeWithSugar
  attr_accessor :making_time, :name

  def initialize
    @coffee = Coffee.new
    @name   = "Coffee with sugar"
  end

  def making_time
    @coffee.making_time += 0.5 #minutes
  end
end

# coffee = Coffee.new
# coffee = CoffeeWithCream.new(coffee)
# coffee = CoffeeWithSugar.new(coffee)

class PumpkinSpiceLatte
  attr_accessor :name, :making_time
  def initialize
    @name        = "Pumpkin Spice Latte"
    @making_time = 4 #minutes
  end
end

class Ristretto
  attr_accessor :name, :making_time
  def initialize
    @name        = "Ristretto"
    @making_time = 5 #minutes
  end
end

class Affogato
  attr_accessor :name, :making_time
  def initialize
    @name        = "Affogato"
    @making_time = 5 #minutes
  end
end

class KopiLuwak
  attr_accessor :name, :making_time
  def initialize
    @name        = "Kopi Luwak"
    @making_time = 7.50 #minutes
  end
end