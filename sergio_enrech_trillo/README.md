[![Build Status](https://travis-ci.org/tigretoncio/ecommerce-test.svg?branch=wip)](https://travis-ci.org/tigretoncio/ecommerce-test)[![Coverage Status](https://coveralls.io/repos/github/tigretoncio/ecommerce-test/badge.svg?branch=master)](https://coveralls.io/github/tigretoncio/ecommerce-test?branch=master)

# Solution

Author: Sergio Enrech Trillo

## Usage

Items are defined, instantiating new objects from the Item class, providing the product `code`, `name` and `price` of product.  Define as many items as you wish.

Then define promotions, instantiating new Promotion object, with promo `id`, `type`, (at the moment they are 2 main type provided, either discount over total bill, named "volume discount", or discounted promo price when buy multiple items of an item, named `"multiple_buy"`), the minimum buy quantity for the promotion to apply (`quantity`), and the `promo_price`

After that, just instantiate a `PromotionRules` object which is the collection of the promotional rules added.

Finally, define a `Checkout` object, passing as parameters a new basket and the promo_rules object created before.

At that point the checkout object can scan items, and calculate a total, providing the value in a formatted string with the pound symbol at the beginning.

An IRB example:

```
sergio@linux ~/Ronin/Tech-tests/babylon (wip *)
$ irb
2.3.1 :001 > item1 = Item.new(code: :"001", name: "Lavender heart", price: 9.25)
 => #<Item:0x00000001c81468 @code=:"001", @name="Lavender heart", @price=9.25> 
2.3.1 :002 > item2 = Item.new(code: :"002", name: "Personalised cufflinks", price: 45)
 => #<Item:0x00000001c64548 @code=:"002", @name="Personalised cufflinks", @price=45> 
2.3.1 :003 > item3 = Item.new(code: :"003", name: "Kids T-shirt", price: 19.95)
 => #<Item:0x00000001c16ed8 @code=:"003", @name="Kids T-shirt", @price=19.95> 
2.3.1 :004 > promo1 = Promotion.new(id: :promo1, type: :"multiple_buy", params: { code: :"001", quantity: 2, promo_price: 8.50 })
 => #<Promotion:0x00000001a802e0 @id=:promo1, @type=:multiple_buy, @params={:code=>:"001", :quantity=>2, :promo_price=>8.5}> 
2.3.1 :005 > promo2 = Promotion.new(id: :promo2, type: :"vol_discount", params: { min_purchase: 60, discount: 0.1 }) 
 => #<Promotion:0x00000001a6f328 @id=:promo2, @type=:vol_discount, @params={:min_purchase=>60, :discount=>0.1}> 
2.3.1 :006 > promo3 = Promotion.new(id: :promo3, type: :"multiple_buy", params: { code: :"002", quantity: 2, promo_price: 40 })
 => #<Promotion:0x00000001df5178 @id=:promo3, @type=:multiple_buy, @params={:code=>:"002", :quantity=>2, :promo_price=>40}> 
2.3.1 :007 > 
2.3.1 :008 >   rules = PromotionRules.new(promo1,promo2,promo3)
 => #<PromotionRules:0x00000001dcfcc0 @all=[#<Promotion:0x00000001a802e0 @id=:promo1, @type=:multiple_buy, @params={:code=>:"001", :quantity=>2, :promo_price=>8.5}>, #<Promotion:0x00000001a6f328 @id=:promo2, @type=:vol_discount, @params={:min_purchase=>60, :discount=>0.1}>, #<Promotion:0x00000001df5178 @id=:promo3, @type=:multiple_buy, @params={:code=>:"002", :quantity=>2, :promo_price=>40}>]> 
2.3.1 :009 > 
2.3.1 :010 >   co = Checkout.new(basket: Basket.new, promo_rules: rules)
 => #<Checkout:0x00000001db4150 @basket=#<Basket:0x00000001db41c8 @basket=[]>, @promo_rules=#<PromotionRules:0x00000001dcfcc0 @all=[#<Promotion:0x00000001a802e0 @id=:promo1, @type=:multiple_buy, @params={:code=>:"001", :quantity=>2, :promo_price=>8.5}>, #<Promotion:0x00000001a6f328 @id=:promo2, @type=:vol_discount, @params={:min_purchase=>60, :discount=>0.1}>, #<Promotion:0x00000001df5178 @id=:promo3, @type=:multiple_buy, @params={:code=>:"002", :quantity=>2, :promo_price=>40}>]>> 
2.3.1 :011 > 
2.3.1 :012 >   
2.3.1 :013 >   co.scan(item1)
 => [#<Item:0x00000001c81468 @code=:"001", @name="Lavender heart", @price=9.25>] 
2.3.1 :014 > co.scan(item2)
 => [#<Item:0x00000001c81468 @code=:"001", @name="Lavender heart", @price=9.25>, #<Item:0x00000001c64548 @code=:"002", @name="Personalised cufflinks", @price=45>] 
2.3.1 :015 > co.scan(item3)
 => [#<Item:0x00000001c81468 @code=:"001", @name="Lavender heart", @price=9.25>, #<Item:0x00000001c64548 @code=:"002", @name="Personalised cufflinks", @price=45>, #<Item:0x00000001c16ed8 @code=:"003", @name="Kids T-shirt", @price=19.95>] 
2.3.1 :016 > co.total
 => "£66.78" 
2.3.1 :017 > 
```


## Comment

This is a flexible approach, as multiple PromotionalRule objects can be coexisting, and therefore different items can have different promotional rules depending on location on any other variables.  Also, it allows to define many products to apply the "multiple discount" promotion, not just a single one.  The "volume discount" has been defined unique, but separated in methods and defined in the calculations class, so it can be easily amended to include other type of volume discount by ranges, (for e.g. price<60 no discount, 60<basket<100 10%, 100<basket<500 12% etc.)





## The Test
Our client is an online marketplace, here is a sample of some of the products available on our site:


| Product  code | Name                   | Price  |
|---------------|------------------------|--------|
| 001           | Lavenderheart          | £9.25  |
| 002           | Personalised cuff links| £45.00 |
| 003           | KidsT­shirt            | £19.95 |


Our marketing team want to offer promotions as an incentive for our customers to purchase these items.
If you spend over £60, then you get 10% off of your purchase. If you buy 2 or more lavender hearts then the
price drops to £8.50.
Our check­out can scan items in any order, and because our promotions will change, it needs to be flexible
regarding our promotional rules.
The interface to our checkout looks like this (shown in Ruby):

```
co=Checkout.new​(promotional_rules)
co.scan​(item)
co.scan​(item)
price=co.total
```

Implement a checkout system that fulfills these requirements. Do this outside of any frameworks. We’re
looking for candidates to demonstrate their knowledge of TDD.

##Testdata

```
Basket:001,002,003
Totalpriceexpected:£66.78
```

```
Basket:001,003,001
Totalpriceexpected:£36.95
```

```
Basket:001,002,001,003
Totalpriceexpected:£73.76
```
