use context dcic2024

import math as M
import statistics as S

cafe-data=
  table: day, drinks-sold
    row: "Mon", 45
    row: "Tue", 30
    row: "Wed" , 55
    row: "Thu", 40
    row: "Fri", 60
  end

sales = cafe-data.get-column("drinks-sold")
# basic stats
M.max(sales)
S.mean(sales)
S.median(sales)
M.sum(sales)

discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]
unique-codes = distinct(discount-codes)

fun is-real-code(code :: String) -> Boolean:
  not(string-to-lower(code) == "none")
end
real_codes = filter(is-real-code, unique-codes)
first-code = real-codes.get(0)
lower-codes = map(string-to-lower, real-codes)

new-lower-codes = map(string-to-lower, discount-codes)
map(is-real-code