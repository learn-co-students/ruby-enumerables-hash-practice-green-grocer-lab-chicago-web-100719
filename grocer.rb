def consolidate_cart(cart)
  cart_hash = {}
  cart.each{
    |array| array.each do
    |item, values| cart_hash[item] ||= values
    cart_hash[item][:count] ? cart_hash[item][:count] +=1 :
    cart_hash[item][:count] = 1 
  end
  }
  cart = cart_hash
return cart

end

def apply_coupons(cart, coupons)
  coupons.each{
    |coupon| coupon.each do
    |attribute, value| 
    name = coupon[:item]
    
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += coupon[:num] 
      else 
        cart["#{name} W/COUPON"] = {:price => (coupon[:cost] / coupon[:num]), :clearance => cart[name][:clearance], :count => coupon[:num]} 
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  }
  return cart
end


def apply_clearance(cart)
  cart.each{
      |name, attributes|
      if attributes[:clearance] == true 
        attributes[:price] = (attributes[:price] * 0.8).round(2)
      end
  }
  return cart
end


def checkout(cart, coupons)
  
  total = 0
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  clearance_cart.each{|item, attributes|
    total += (attributes[:price] * attributes[:count])
  }
   total
   
   if total > 100
     total = (total * 0.9).round(2)
   end
   
   return total
  
end
