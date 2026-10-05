use context dcic2024
include csv
include data-source


# Problem 1: Leap Years
fun leap_year(year :: Number) -> Boolean:
  doc: "takes any year and tells us whether that year was a leap year or not"
  if num-modulo(year, 400) == 0:
    true
  else if num-modulo(year, 100) == 0:
    false
  else if num-modulo(year, 4) == 0:
    true
  else: 
    false
  end
  
where:
  leap_year(1900) is false
  leap_year(2024) is true
  leap_year(2028) is true
  leap_year(2026) is false
  leap_year(2100) is false
  leap_year(2400) is true
end

# The conditions for a leap year are if it is directly divisible by 400 it is a leap year, and if it is divisible by 4 it is also a leap year unless it is divisible by 100 but not 400. Divisible by 4 alone is not sufficient, as years like 1900 can pass this test. This is why the function first checks if the year is divisible by 400; if it fails this test then it can be checked for 100, and if it passes the 100 test then we know for sure it is not a leap year.

# 2. Tick Function

fun tick(seconds :: Number) -> Number:
  doc: "Takes the input as seconds and returns the next second"
  if seconds == 59:
      0
  else:
    seconds + 1    
  end
where:
  tick(59) is 0
  tick(0) is 1
  tick(42) is 43
end

# The seconds are from 0-59. We establish the "outlying" condition that when it hits 59 it should return 0 as a clock never says 60 on it. For all other cases 0-58 it can add 1 with no issues. 

# 3. Rock Paper Scissors

fun rps(p1 :: String, p2 :: String) -> String:
  if not((p1 == "rock") or (p1 == "paper") or (p1 == "scissor")):
    "invalid choice"
  else if 
      not((p2 == "rock") or (p2 == "paper") or (p2 == "scissor")):
      "invalid choice"
  else if
    p1 == p2:
    "tie"
  else if
    ((p1 == "rock") and (p2 == "scissor")) or ((p1 == "paper") and (p2 == "rock")) or ((p1 == "scissor") and (p2 == "paper")):
    "player 1"
  else:
    "player 2"
  end
where:
  rps("fire", "rock") is "invalid choice"
  rps("rock", "water") is "invalid choice"
  rps("rock", "scissor") is "player 1"
  rps("scissor", "scissor") is "tie"
  rps("paper", "scissor") is "player 2"
end

# First we make sure that the function only takes rock, paper and scissor as valid inputs, then write down all the possible ways p1 can win, and any other valid input not already listed would mean p2 won. 

# 4. Planets:

planets = table: Planet :: String, Distance :: Number
  row: "Mercury", 0.39
  row: "Venus", 0.72
  row: "Earth", 1
  row: "Mars", 1.52
  row: "Jupiter", 5.2
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end

mars = planets.row-n(3)
mars["Distance"]

# 5. Official Bank Rate history data Bank of England

something = load-table:
  year :: Number,
  day :: Number,
  month :: String,
  rate :: Number
  source: csv-table-file("boe_rates.csv", default-options)
  sanitize year using num-sanitizer
  sanitize day using num-sanitizer
  sanitize rate using num-sanitizer
end 

something.length()

median(something, "rate")
modes(something, "rate")

something.order-by("rate", true)
something.order-by("rate", false)

# the minimum value for "rate" is 0.1, while the maximum value is 17.