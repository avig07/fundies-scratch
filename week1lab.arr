use context starter2024
#| 1. T-Shirt Shop
   
   1.1 Calculating Cost |#

(12 * 5) + 3

(12 * 7) + 3

# The one-time setup fee is added at the end, while you pay 12 pounds for the design and 5 or 7 is the quantity

# 1.2 Rectangular Poster

# perimeter of the poster
2 * (420 + 594)
# = 2028

# price of the poster
2028 * 0.10
# = 202.8 GBP

# If you forget the parentheses around 2 * (width + height) the 2 multiplies with the width first then adds on the height, but we need to add both the width and the height first then multiply it by 2. 

#| 2. String Surprises
   
   2.1 Saving a Tagline |#

'Designs for everyone!' # typed in as a string
# omitting the quotation mark gives the error saying I might be missing closing punctuation, hence the quotation marks around it make it a string and valid. 

# 2.2 Colour Inventory
"red" + "blue"
# the strings print together 

# the operator only expects to be given two numbers or two strings in an expression hence 1 + "blue" gives an error. 

# 3. Make a Traffic Light

base = rectangle(70, 140, "solid", "black")

stop = circle(20, "solid", "red")
brake = circle(20, "solid", "orange")
go = circle(20, "solid", "green")
stop_brake = above(brake, stop)
lights_only = above(go, stop_brake)
lights_only

lights = overlay-xy(lights_only,-13,-7, base)
lights

# Rectangular below
pole = rectangle(15, 140, "solid", "grey")

full_light = above(lights, pole)
full_light
# We put the lights above the rectangle

# 4. Broken Code Hunt
# Goal: A rectangle with width 50 and height 20, solid black
#| rectangle(50, "solid", 20, "black")
   the 2nd input has to be the width, the '20' and solid need to be switched around |#
rectangle(50, 20, "solid", "black")


# 5. Flag Design

emblem = rotate(45, (star(35, "solid", "black")))
flag_base = rectangle(250, 125, "solid", "white")
flag_1 = overlay-xy(emblem, 0, -3, flag_base)
flag_1
red_1 = rectangle(45, 125, "solid", "red")
final_flag = overlay-xy(red_1, -205, 0, flag_1)
final_flag

# 5.1 Shield Design

ball = circle(50, "solid", "yellow")
outer = circle(51, "outline", "blue")
full_ball = overlay(outer, ball)
redstar = star(35, "solid", "red")
overlay(redstar, full_ball)