use context dcic2024
include csv
include data-source



table1 = table: date :: String, activity :: String, duration :: Number
  row: "2026-04-01", "Running", 30
  row: "2026-04-02", "Swimming", 20
  row: "2026-04-03", "Cycling", 60
  end 


# to get values from rows
first_row = table1.row-n(0)
first_row["activity"]

#to get all values in a specific column
table1.get-column("activity")

# basic stats
mean(table1, "duration")
median(table1, "duration")
stdev(table1, "duration")
modes(table1, "activity")

#import csv from URL

recipes = load-table:
  title :: String,
  servings :: Number,
  prep-time :: Number
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/recipes.csv", default-options)
  sanitize servings using num-sanitizer
  sanitize prep-time using num-sanitizer
end

  
recipes

recipes.length()
mean(recipes, "prep-time")


recipes = load-table:
  title :: String, 
  servings :: Number, 
  prep-time :: Number
  source: csv-table-