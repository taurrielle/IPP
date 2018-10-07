In this laboratory work I used three creational design patterns: **abstract factory**, **singleton** and **prototype**. 

1. **Abstract factory**

In this laboratory work I created a pizza store that serves, you guessed it, PIZZA. However, it also has wine and a sommelier that serves it. This sommelier is a really crappy one if you ask me because he serves only two types of wine: red and white. But his skills are not the point here. 

``` ruby
class Sommelier
  def initialize(wine_type)
    @wine_type = wine_type
  end

  def serve!
    @wine_type.serve
  end
end 
```

The type of wine desired is passed in and set in the initialize method. In the serve! method, we are calling the serve method of the factory that has been passed in upon initialization. Since both the RedWine class and the WhiteWine class have the serve method this will work without errors.

2. **Singleton**
The Singleton pattern ensures a class has only one instance and provides a global point of access to it. Ruby comes with a standard module that I used in my program. I made my PizzaStore class a singleton because there can be only one such pizza store. It's not a chain restaurant. Rather, it is a lovely, small, one of a kind restaurant.

3. **Prototype**
The prototype pattern specifies the kinds of objects to create using a prototypical instance, and create new objects by copying this prototype.



