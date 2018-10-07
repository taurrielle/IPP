require './lab1.rb'
require 'pry'

pizza_store = PizzaStore.instance
margherita_pizza       = Pizza.new('Margherita', ['cheese', 'tomato sauce', 'basil'])
quattro_stagioni_pizza = Pizza.new('Quattro Stagioni', ['cheese', 'tomato sauce', 'artichokes', 'olives', 'prosciutto', 'mushrooms'])
quattro_fromagi_pizza  = Pizza.new('Quattro Fromagi', ['tomato sauce', 'mozzarella', 'fontina', 'stracchino', 'gorgonzola'])
marinara_pizza         = Pizza.new('Marinara', ['marinara sauce', 'bazil', 'garlic'])
calzone_pizza          = Pizza.new('Calzone', ['tomato sauce', 'ham', 'mozzarella', 'ricotta', 'parmezan', 'olives', 'egg'])

pizza_store.pizza_prototype_collection['margherita']       = margherita_pizza
pizza_store.pizza_prototype_collection['quattro_stagioni'] = quattro_stagioni_pizza
pizza_store.pizza_prototype_collection['quattro_fromagi']  = quattro_fromagi_pizza
pizza_store.pizza_prototype_collection['marinara']         = marinara_pizza
pizza_store.pizza_prototype_collection['calzone']          = calzone_pizza

puts "Welcome to the Best Pizza Store in the world! Please select a pizza from the options below:\n\n"
pizza_store.pizza_prototype_collection.each_value do |pizza|
  puts "#{pizza.name}\n"
end

ordered_pizza = gets.chomp

puts "Would you like wine with your pizza?"
if gets.chomp == 'y'
  puts "Please select red or white wine"
  wine = gets.chomp


  ordered_wine = case wine
  when 'red'
    RedWine.new
  when 'white'
    WhiteWine.new
  else
    puts "No such wine\n"
  end
end

pizza_store.take_pizza_order(ordered_pizza)
pizza_store.take_wine_order(ordered_wine) if ordered_wine