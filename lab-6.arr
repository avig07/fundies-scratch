use context dcic2024
# Avi Gupta

# Task 1: Expressions
# 1. I think the expression will return 25 * 0.15 which is 3.75
25 * 0.15
# I think the expression will return "Electric bike" as the strings are joined with a space in the middle and with '+'
"Electric" + " " + "bike"
# I think string-length("handlebar") will return the number of characters in the word "handlebar" which is 9
string-length("handlebar")


# Task 2: Definitions and functions

# assigning 0.15 under the name minute-rate
minute-rate :: Number = 0.15



fun ride-cost(minutes :: Number, price-per-minute :: Number) -> Number:
  doc: "takes the length of a ride in minutes and price per minute and returns the total cost of the ride"
  minutes * price-per-minute 
where:
  ride-cost(25, minute-rate) is 3.75
  ride-cost(50, 0.2) is 10
  ride-cost(20, 0.5) is 10
  ride-cost(90, 0.35) is 31.5
  
end

# Task 3: Conditionals and tests

fun ride-discount(length-of-ride :: Number) -> Number: 
  doc: "returns the discount for a ride lasting the duration given"
  if length-of-ride < 30:
    0
  else if length-of-ride <= 59: 
    0.1
  else:
    0.2
  end
where: # checking both sides of the boundaries
    ride-discount(29) is 0
  ride-discount(30) is 0.1
  ride-discount(59) is 0.1
    ride-discount(60) is 0.2
end

# Task 4: Tables

rides = table: rider, minutes, rate
  row: "Ella", 20, 0.15
  row: "Farid", 45, 0.10
  row: "Grace", 70, 0.10
  row: "Hugo", 10, 0.20
end

# first we define the get-column function from earlier lectures

fun get-column(r :: Row, colname :: String):
  doc: "function returns value in row r for the column"
  r[colname]
where:
  get-column(rides.row-n(0), "rider") is "Ella"
  get-column(rides.row-n(1), "minutes") is 45
end

# now use it to get values from individual rows 
build-column(rides, "cost", lam(x): get-column(x, "minutes") * get-column(x, "rate") end)

# filter-with more than 30 minutes

rides-thirty-mins-or-more = filter-with(rides, lam(x): get-column(x, "minutes") >= 30 end)

# Task 5: List, loops and folds

# the definition
minutes-list = rides.get-column("minutes")

# done with for each

fun total-minutes-loop(nums :: List<Number>) -> Number block:
  doc: "Adds the numbers using a loop and keeps a running total."
  var total = 0
  for each(n from nums):
    total := total + n
  end
  total
where:
  total-minutes-loop([list:]) is 0
  total-minutes-loop([list: 10, 20, 30]) is 60
end

# same function with fold
fun total-minutes-fold(nums :: List<Number>) -> Number:
  doc: "Adds the numbers using fold while starting from zero"
  for fold(total from 0, n from nums):
    total + n
  end
where:
  total-minutes-fold([list:]) is 0
  total-minutes-fold([list: 10, 20, 30]) is 60
end

# check to make sure both return the same values
check:
  total-minutes-loop(minutes-list) is 145
  total-minutes-fold(minutes-list) is
    total-minutes-loop(minutes-list)
end

# Task 6: Structured data and recursion

data Ride:
  | pedal-bike(minutes :: Number)
  | e-bike(minutes :: Number, has-pass :: Boolean)
end

fun battery-fee(ride :: Ride) -> Number:
  doc: "returns the battery fee in pounds: 0.05 per minute for an e-bike ride without a pass, and 0 otherwise."
  cases(Ride) ride:
    | pedal-bike(minutes) => 0
    | e-bike(minutes, has-pass) => if has-pass == true: 0 else: minutes * 0.05 end
  end
  

where:
  battery-fee(pedal-bike(20)) is 0
  battery-fee(e-bike(20, true)) is 0
  battery-fee(e-bike(20, false)) is 1
  battery-fee(e-bike(0, false)) is 0
end


fun total-minutes-rec(nums :: List<Number>) -> Number:
  doc: "Adding a list of numbers using recursion"
  cases (List) nums:
    | empty => 0
    | link(first, rest) =>
      # Add the first number to the sum of the remaining numbers.
      first + total-minutes-rec(rest)
  end
where:
  total-minutes-rec([list:]) is 0
  total-minutes-rec([list: 10]) is 10
  total-minutes-rec([list: 20, 45, 70, 10]) is 145
end