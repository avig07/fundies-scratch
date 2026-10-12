use context dcic2024
include csv


#A higher-order function which takes a function as one of its arguments
# filter-with(function)

orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00 #index 2
  row: "11:00", 3.95 #index 3
  row: "14:00", 4.95 #index 4
  row: "16:45", 7.95
end

fun is-high-value(o :: Row) -> Boolean:
  o["amount"] >= 8.0 # function within a function
where: 
  is-high-value(orders.row-n(2)) is true #expecting a row here, we provide a row using row-n()
  is-high-value(orders.row-n(4)) is false
end

fun compute-sum(n1 :: Number, n2 :: Number) -> Number:
  doc: "The function takes two numbers and returns the sum"
  n1 + n2
where: 
  compute-sum(3,3) is 6
  compute-sum(6,9) is 15
  compute-sum(4,2) is 6
end

new-high-order = filter-with(orders, is-high-value)
high-value-orders = table: time, amount
  row: "08:00", 10.50
  row: "10:15", 8.00
end

check: 
  new-high-order is high-value-orders
end 

filter-with(orders, lam(o): o["amount"] >= 8.0 end)

# order-by

order-by(orders, "amount", true) # for ascending
order-by(orders, "amount", false) # for descending

fun is-morning(o :: Row) -> Boolean:
  o["time"] <= "12:00"
where:
  is-morning(orders.row-n(0)) is true
  is-morning(orders.row-n(1)) is true
  is-morning(orders.row-n(2)) is true
  is-morning(orders.row-n(4)) is false
end

only_morning = filter-with(orders, lam(o): o["time"] <= "12:00" end)
only_morning