use context starter2024

# 'radius' is the name
# the following line can be read as 'radius is defined to be 9'
radius = 9 # this statement is a definition

# few more examples

books = 7
weight = 70
height = 5

bmi = weight * height # expression, a code that computes something

# statement --> a code that instructs rather than computes
# a definition is a statement


flag-before = above(rectangle(140, 40, "solid", "blue"), rectangle(140, 40, "solid", "red"))
flag-before


# class exercises

# Exercise 2
side-length = 60
square-colour = 'seagreen'

named-square = square(60, "solid", "blue")
named-square

#Exercise 3 

plain-square = square(60, "solid", "blue")

check "same image, different code":
  named-square is plain-square
end

# example of some checks

area = 3 * 5

check "area is 15":
  area is 10
end
