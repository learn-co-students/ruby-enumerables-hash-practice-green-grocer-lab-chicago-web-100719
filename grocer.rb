def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item_hash|
              item_hash.each do |item, price_hash|
                new_cart[item] = price_hash

                if !new_cart[item][:count]
                new_cart[item][:count] = 1
                else
                new_cart[item][:count] += 1
                end

              end
            end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
                item = coupon[:item]

                if cart[item] && cart[item][:count] >= coupon[:num]
                  if cart["#{item.upcase} W/COUPON"]
                  cart["#{item.upcase} W/COUPON"][:count] += coupon[:num]
                  else
                  cart["#{item.upcase} W/COUPON"] = { price: coupon[:cost] / coupon[:num], count: coupon[:num], clearance: cart[item][:clearance] }
                  end
                else
                  return cart
                end

                cart[item][:count] -= coupon[:num]
              end
  cart
end

def apply_clearance(cart)
  cart.each do |item, item_hash|
                if item_hash[:clearance] == true
                  item_hash[:price] = (item_hash[:price] * 0.8).round(2)
                end
            end
  cart
end

def checkout(cart, coupons)
  total = 0
  new_cart = consolidate_cart(cart)
  discount_cart = apply_coupons(new_cart, coupons)
  final_cart = apply_clearance(discount_cart)

  final_cart.each do |item, item_hash|
                    total += ( item_hash[:price] * item_hash[:count] )
                  end

  total = total * 0.9 if total > 100
  total
end
