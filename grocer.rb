def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item|
    item.each do |name, item_hash| 
      if new_hash[name]
        new_hash[name][:count] += 1 
      else
        new_hash[name] = item_hash
        new_hash[name][:count] = 1 
      end
    end
  end
  return new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon| 
    coupon.each do  
      name = coupon[:item] 
    
      if cart[name] && cart[name][:count] >= coupon[:num] 
        if cart["#{name} W/COUPON"] 
          cart["#{name} W/COUPON"][:count] += coupon[:num] 
        else 
          cart["#{name} W/COUPON"] = {:price => coupon[:cost] / coupon[:num], 
          :clearance => cart[name][:clearance], :count => coupon[:num]} 
        end 
  
      cart[name][:count] -= coupon[:num] 
    end 
  end 
end 
  cart 
end

def apply_clearance(cart)
  cart.each do |item, hash|
    if hash[:clearance] == true 
      hash[:price] = (hash[:price] * 0.8).round(2)
    end 
  end
  return cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
total = 0
  clearance_cart.each do |item, hash|
    total += (hash[:price] * hash[:count])
  end
  if total > 100
    total = (total * 0.9).round(2)
  else
    total = total.round(2)
  end
  return total 
end


