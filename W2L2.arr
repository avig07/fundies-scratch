use context starter2024

x = "Avi"
y = "Jonathan"

fun welcome(name ,  name0):
  "Welcome to class, " + name + " & " + name0
end

welcome(x , y)

fun perimeter(width, l):
  2 * (l + width)
end 

check:
  perimeter(3, 4) is 2 * (3 + 4)
  perimeter(6, 9) is 2 * (6 + 9)
end

fun design(message, quantity):
  quantity * (5.00 + (string-length(message) * 0.10))
end

design("Go Team!", 4)
design("Hello World", 7)
    