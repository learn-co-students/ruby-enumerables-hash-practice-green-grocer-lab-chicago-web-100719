

def consolidate_cart(cart)
  grocery_hash = {}
  cart.each do |item|
    item_name = item.keys[0]
    atributes = item.values[0]
    if grocery_hash.has_key?(item_name)
      atributes[:count] += 1 
    else grocery_hash[item_name]= atributes
      atributes[:count] = 1 
    end
end
grocery_hash
end




def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    coupon_item = "#{item} W/COUPON"
    if cart.has_key?(item)
      if cart[item][:count] >= coupon[:num] && !cart.has_key?(coupon_item)
         cart[coupon_item] = {price: coupon[:cost] / coupon[:num] , clearance: cart[item][:clearance] , count: coupon[:num] }
         cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart.has_key?(coupon_item)
       cart[coupon_item][:count] += coupon[:num]
       cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end




def apply_clearance(cart)
  cart.each do |item,atributes|
    if atributes[:clearance] == true
    atributes[:price] -= atributes[:price] * 0.2 
  end
 end 
 cart
end





def checkout(cart, coupons)
  hash_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(hash_cart,coupons)
  applied_discount = apply_clearance(applied_coupons)
  total = applied_discount.reduce(0) {|acc,(key,value)| acc += value[:price] * value[:count]}
  if total > 100 
    total * 0.9
  else total
 end
end












