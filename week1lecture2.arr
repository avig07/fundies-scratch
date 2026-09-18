use context starter2024
a = 'Hello World'

b = a + ' '

string-length(b)
string-repeat(b, 2)

"CS" + "2000"

# converting all string characters to upper case

string-to-upper("hello cs2000!") # -> HELLO CS2000

# converting all string characters to lower case

string-to-lower("WELCOME TO CS2000")

# to get a substring

string-substring("Welcome to London", 0, 7)

sample_string = "Hello, how are you? My name is Avi"

# checking if certain characters exist in a string
string-contains(sample_string, "Avi")
string-contains(sample_string, "avi")

# shapes in python
circle(30, "solid", "white")
rectangle(45,40, "solid", "green")
triangle(50,"solid", "red")

# composition, each of these take two images and give back one image

# overlay((First Image), (Second Image))

overlay(circle(30, "outline", "blue"), rectangle(80,70, "solid", "yellow"))

# above((First Image), (Second Image))
above(circle(30, "solid", "blue"), rectangle(80,70, "solid", "yellow"))

# below((First Image), (Second Image)) 
below(circle(30, "solid", "blue"), rectangle(80,70, "solid", "yellow"))

# beside((First Image), (Second Image)) 
beside(circle(30, "solid", "blue"), rectangle(80,70, "solid", "yellow"))


octagon1 = regular-polygon(60, 8 , "outline", "white")
octagon2 = regular-polygon(59, 8, "solid", "red")
stop = text("STOP", 35, "white")
oct3 = overlay(octagon1, octagon2)
overlay(stop, oct3)