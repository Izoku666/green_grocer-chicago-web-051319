def consolidate_cart(cart)
  # code here
  
  res = {}
  cart.each do |i|
    i.each do |k , v|
      #puts "k: #{k} , v: #{v}"
      if !res.include?(k)
        res[k] = {}
        res[k][:count] = 1
        res[k][:clearance] = i[k][:clearance]
        res[k][:price] = i[k][:price]
      else
        res[k][:count] += 1
      end
    end
  end
  
  cart = res
  return cart
end

def apply_coupons(cart, coupons)
  #puts "cart:   #{cart}"
  temp = []
  cart.each do |item , info|
    coupons.each do|i|
     # puts i[:item]
      if item == i[:item] && !temp.include?(i[:item]) #  if the cart item matches the coupon , make a coupon
        s = "#{item} W/COUPON"
        
        n_c =  {s => {
          :price => i[:cost],
          :count => i[:num] / cart[item][:count],  #:count => 1,
          :clearance => cart[item][:clearance]
        }}
        # n_c[s]
        
        puts n_c[s][:count]
        #puts "#{i[num]} / #{cart[item][:count]} = #{i[:num] / cart[item][:count}"
        #keep this line
        cart[item][:count] %= i[:num]
        
        if !temp.include?(n_c)
          temp << n_c
        end
      end
    end
  end
  
  temp.each do |i|
    i.each do |item_name, info|
      cart[item_name] = info
    end
  end
  

    
  
  #puts "Temp:   #{temp}"

#  puts "result: #{cart}"
  return cart
end

def apply_clearance(cart)
  # code here
  #puts cart
  cart.each do |k , v|
    #puts "*********** the key is #{k}"
    if cart[k][:clearance] == true
      #this returns true, something else is happening
      cart[k][:price] -= (cart[k][:price] * 0.2)
    end
  end
  
  return cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart , coupons)
  apply_clearance(new_cart)
  
  
  # ///////////////////////   SUM CALCULATION
  sum = 0
  new_cart.each do |k , v|
    sum += (new_cart[k][:price] * new_cart[k][:count])
  end
  
  if sum > 100
    sum -= (sum * 0.1)
  end
  
  return sum
end
