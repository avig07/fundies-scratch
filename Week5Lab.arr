use context dcic2024
include csv
include data-source

# exercise 1.1
flights = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: Number,
  tailnum :: String,
  origin :: String,
  dest :: String,
  air_time :: Number, 
  distance :: Number,
  hour :: Number, 
  minute :: Number,
  time_hour :: String
  source: csv-table-file("flights.csv", default-options)
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize flight using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end

# Exercise 1.2: is_long_flight function
fun is_long_flight(row :: Row) -> Boolean:
doc: "takes the distance value and checks if it is greater than or equal to 1500"
if row["distance"] >= 1500:
  true
else:
  false
end
where:
  is_long_flight(flights.row-n(0)) is false
  is_long_flight(flights.row-n(1)) is false
  is_long_flight(flights.row-n(3)) is true
end

# Exercise 1.3: filter-with function using flights table and is_long_flight predicate

filter-with(flights, is_long_flight)

# Exercise 1.4: order-by function, use false because true is for ascending. 

sorted_flights = order-by(flights, "air_time", false)
# row-n takes the row from the table, in this case the first one as pyret uses zero indexing. then we use row["column"] format to get the particular value from that row. 
first_flight = sorted_flights.row-n(0)
first_flight["carrier"]
first_flight["origin"]
first_flight["dest"]

# Exercise 2.1: Delayed Departure

fun is_delayed_departure(row :: Row) -> Boolean:
  if row["dep_delay"] >= 30:
    true
  else:
    false
  end
where:
  is_delayed_departure(flights.row-n(163)) is true
  is_delayed_departure(flights.row-n(0)) is false
end
  
# Exercise 2.2: Morning Flight


fun is_morning_sched_dep(row :: Row) -> Boolean:
  if row["sched_dep_time"] < 1200:
    true
  else:
    false
  end
where:
  is_morning_sched_dep(flights.row-n(390)) is false
  is_morning_sched_dep(flights.row-n(10)) is true
end

# Exercise 2.3: Filter delayed morning flights

delayed_flights = filter-with(flights,
  lam(row :: Row) -> Boolean:
    doc: "takes a row and checks if the departure delay is greater than or equal to 30 minutes"
    if row["dep_delay"] >= 30:
      true
    else:
      false
    end
  end)

morning_delayed_flights = filter-with(delayed_flights,
  lam(row :: Row) -> Boolean:
    doc: "takes a row and checks if the scheduled departure time is before 1200"
    if row["sched_dep_time"] < 1200:
      true
    else:
      false
    end
  end)


# Exercise 2.4: Filter flights with distance greater than 500

long_morning_delays = filter-with(morning_delayed_flights,
  lam(row :: Row) -> Boolean:
    doc: "takes a row and checks if the flight distance is greater than 500"
    if row["distance"] > 500:
      true
    else:
      false
    end
  end)


# Exercise 2.5: Order flights by departure delay

sorted_delays = order-by(long_morning_delays, "dep_delay", false)

# Exercise 2.6: Extract the worst delayed flight

worst_flight = sorted_delays.row-n(0)

worst_flight["flight"]
worst_flight["origin"]
worst_flight["dep_delay"]


# Exercise 3.1.1: Clean departure delays

clean_dep_delays = transform-column(flights, "dep_delay",
  lam(delay :: Number) -> Number:
    doc: "takes a departure delay and replaces negative values with 0"
    if delay < 0:
      0
    else:
      delay
    end
  end)

# 3.1.2: Clean arrival delays:

clean_delays = transform-column(clean_dep_delays, "arr_delay",

  lam(delay :: Number) -> Number:

    doc: "takes an arrival delay and replaces negative values with 0"

if delay < 0:
      0
    else:
      delay
    end
  end)

# Exercise 3.2: Calculate effective speed

speed_flights = build-column(clean_delays, "effective_speed",
  lam(row :: Row) -> Number:
    doc: "takes a flight row and calculates its effective speed in miles per hour"
    if row["air_time"] > 0:
      row["distance"] / (row["air_time"] / 60)
    else:
      0 # we take airtime as >0 because dividing by zero would be undefined
    end
  end)


# Exercise 3.3: Order by effective speed

sorted_speed = order-by(speed_flights, "effective_speed", false)# again, true is ascending and false is descending

# Exercise 3.4: Extract fastest flight

fastest_flight = sorted_speed.row-n(0)

fastest_flight["carrier"]
fastest_flight["origin"]
fastest_flight["dest"]

# retrieving the carrier, origin and destination from the top as the highest. 

# Exercise 4.1: Apply arrival discount

fun apply-arrival-discount(t :: Table) -> Table: # takes columns and not rows, hence table. 
  doc: "takes a table and reduces arrival delays between 0 and 45 by 20%"

  transform-column(t, "arr_delay",
    lam(delay :: Number) -> Number:
      doc: "takes an arrival delay and reduces it by 20% if it is between 0 and 45"
      if (delay >= 0) and (delay <= 45):
        delay * 0.8
      else:
        delay
      end
    end)

where:
  test_flights = table: arr_delay
    row: -10
    row: 0
    row: 30
    row: 60
  end

  discounted_test = apply-arrival-discount(test_flights)

  discounted_test.row-n(0)["arr_delay"] is -10
  discounted_test.row-n(1)["arr_delay"] is 0
  discounted_test.row-n(2)["arr_delay"] is 24
  discounted_test.row-n(3)["arr_delay"] is 60
end

discounted_flights = apply-arrival-discount(flights)


# Exercise 4.2: Calculate on-time score

scored_flights = build-column(discounted_flights, "on_time_score",
  lam(row :: Row) -> Number:
    doc: "takes a flight row and calculates its on-time score"

    dep_delay = if row["dep_delay"] < 0:
      0
    else:
      row["dep_delay"]
    end

    arr_delay = if row["arr_delay"] < 0:
      0
    else:
      row["arr_delay"]
    end

    score = 100 - (dep_delay - arr_delay) - (row["air_time"] / 30)

    if score < 0:
      0
    else:
      score
    end
  end)


# Exercise 4.3: Order by on-time score and distance

sorted_distance = order-by(scored_flights, "distance", true)

sorted_scores = order-by(sorted_distance, "on_time_score", false)


# Exercise 4.4: Extract top two flights

f_flight = sorted_scores.row-n(0)

f_flight["carrier"]
f_flight["flight"]
f_flight["origin"]
f_flight["dest"]

second_flight = sorted_scores.row-n(1)

second_flight["carrier"]
second_flight["flight"]
second_flight["origin"]
second_flight["dest"]