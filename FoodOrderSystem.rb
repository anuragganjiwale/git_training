$restaurants_list = ["A","B"]

$dish = {"A" => [{"pulav":100},{"Dal":80}],"B" => [{"Burger":120},{"Pizza":200}]}

$dish_available = {"A" => [{"pulav" =>"yes"},{"Dal" => "no"}],"B" => [{"Burger" => "yes"},{"Pizza" => "yes"}]}


class Order
  @@order_identifier = 0 
	def initialize()
		
		@customer_name = ""
		@restaurant_name = ""
		@amount = 0
    @dishname = ""
    @order_status = "Not Delivered"
    @quantity = 0
    @@order_identifier = @@order_identifier + 1
  
  end

  
  def self.order_id_update

    @@order_identifier

  end



  def check_dish_availability(dish_number)

    check_array = $dish_available[@restaurant_name]
    check = check_array[dish_number.to_i - 1]
    check = check.values
    check = check[0]

    if check == "no"
      return 1
    else 
      return 0
    end

  end


  
  def show_restaurants

    count = 0
    puts "Available Restaurants are : "
    for i in 0..1 do

      count = count + 1
      puts "#{count}. #{$restaurants_list[i]} "
    end
    puts "Select one restaurant : "

    selected_restaurant = gets

    return selected_restaurant

  end



  def get_dishname

    name_of_dish = @restaurant_name
    dishes = $dish[name_of_dish]

    count = 0
    dishes.each do |x|

      count = count + 1
      y = x.keys
      name = y[0]
      y = x.values
      price = y[0]

      puts "#{count}. Dish Name : #{name} , Price : #{price}"
    
  end

    puts "Select a Dish"
    dishname = gets

    check = check_dish_availability(dishname)

    if check == 1
      puts
      puts "Sorry Selected Dish is Not available !!!"
      puts "Try Again"
      dishname = get_dishname()
    end

    return dishname

  end

   
  
  def get_cost

    cost = @price.to_i * @quantity.to_i

    return cost
  
  end


  
  def accept_order()

    puts "Enter your Name : "
    @customer_name = gets

    selected_restaurant = show_restaurants()

    index = selected_restaurant.to_i - 1

    @restaurant_name = $restaurants_list[index]


    dishname = get_dishname()

    c = $dish[@restaurant_name]
    dish_temp = c[dishname.to_i - 1]
    dish_name = dish_temp.keys
    @dishname = dish_name[0]
    price_temp = dish_temp.values
    @price = price_temp[0]

    puts "Enter Quantity of Dish : "
    @quantity = gets

    @amount = get_cost()

    puts "\n\n"
    puts "Order Summary : "

    puts "Customer Name : #{@customer_name}"
    puts "Selected Restaurant : #{@restaurant_name}"
    puts "Selected Dish : #{@dishname}"
    puts "Quantity : #{@quantity}"
    puts "Total Amount to Pay : #{@amount}"
    puts "Order Status : #{@order_status}"
      
    
    puts "Whether order was delivered : (y/n) : "
    status = gets.chomp

    if status == 'Y' or status == 'y'

      @order_status = "Delivered"
      puts "Thank You for ordering !!!"
      
    else

      @order_status = "Pending"
      puts "Please Wait for Some Time"

    end

  end

end


loop do
  order = Order.new()
  order.accept_order()
end
