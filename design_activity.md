What classes does each implementation include? Are the lists the same?
A. Both the implementations have CartEntry,ShoppingCart and Order classes.

Write down a sentence to describe each class.

A.The CartEntry is responsible for unit_price and quantity.
The Shopping cart is responsible for items in CartEntry.
The Order class is responsible for an instance of the Shopping cart class.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
The Shopping cart has a relation with CartEntry.

A.The Order class is responsible for an instance of Shopping cart.So, they have is_a relation .

What data does each class store? How (if at all) does this differ between the two implementations?

A. The CartEntry contains unit_price and quantity.The shopping cart contains an array of all data  of CartEntry.The order class contains a cart which is an instance of Shopping cart and constant(sales_tax)

What methods does each class have? How (if at all) does this differ between the two implementations?

A .In implementation A only the Order class has a total_price method.and in implementation B Cart entry and shopping cart has price method and Order class has a total_price method.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
 A.In A ,logic to price contains in the Order class whereas in B the logic to compute price is delegated to lower level classes.

Does total_price directly manipulate the instance variables of other classes?

A.Yes, it does manipulate in Implementation A but in implementation B it does not manipulate directly but in the method the instance variables are manipulated.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

A.We could change the code in the CartEntry class. Implementation B is easier to modify because it already have a method named price.

Which implementation better adheres to the single responsibility principle?

A.Implementation B better adhere to the single responsibility principle because the logic to compute to the price is delegated to lower level classes.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

A.All the classes in implementation B has less dependency with the other classes.So, B is more loosely coupled.
