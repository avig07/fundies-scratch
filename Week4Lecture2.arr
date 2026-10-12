use context dcic2024

#| 
   The two operations: 
   1. transform-column:
   your function takes: one value
   you get back: same columns, new values in one
   
   2- build-column: 
   your function takes: one whole row
   you get back: one extra column
   
|#

sales = table: item :: String, price:: Number, qty :: Number
  row: "Tea", 2.50, 4
  row: "Coffee", 3.0, 2
  row: "Cake", 4.25, 3
end

# transform column
# add VAT to every price. 
fun add_vat(p :: Number) -> Number:
  doc: "returns the price with 20 percent VAT added"
  p * 1.2
where: 
  add_vat(10) is 12 
  add_vat(0) is 0
end

# transform column: transform-column :: (t :: Table, colname :: String, f :: (A -> B)) -> Table

with-vat = transform-column(sales,"price", add_vat)
sales.get-column("price")
with-vat.get-column("price")


transform-column(sales,"price", lam(p): p * 1.2 end)

# build-column

fun line-total(r :: Row) -> Number: 
  doc: "returns price times quantity for one order line"
  r["price"] * r["qty"]
where: 
  line-total(sales.row-n(0)) is 10
    line-total(sales.row-n(2)) is 12.75
end

with-total