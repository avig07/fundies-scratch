use context starter2024
check:
  true is true 
  not(true) is false
 

# and 
  true and true is true
  false and true is false 
  false and false is false
  (3 > 1) and ((4 * 2) == 8) is true
  (4 < 1) and ((2 + 3) == 5) is false
  
  # or 
  true or false is true 
  false or false is false
  ((3 * 7) == 21) or ("a" == "b") is true 
  
end

fun choose-hat(temp-in-c :: Number) -> String:
  doc: "determines the appropriate head head gear, above 27c a sun hat, below that nothing"
  if temp-in-c > 27:
    "sun hat"
  else:
    "no need"
  end
where: 
  choose-hat(25) is "no need" # checking the function is working as it should. 
  choose-hat(37) is "sun hat"
  choose-hat(27) is "no need"
end 
  
choose-hat(50)

# study comparison, spy, ask 



#| 
  full design recipe
 Four steps: Do them in this order, and write the code last. 
   1. Type annotation ( :: String) -> Number stuff, what goes in and what comes out. 
   2. Docstring: one english sentence saying what the function is for
   
   
   
   
   
|#


fun grades(marks :: Number) -> String:
  doc: "returns a letter grade for a mark /100"
  
  if marks >= 90:
    "A"
  else if marks >= 80:
    "B"
  else if marks >= 70:
    "C"
  else if marks >= 60:
    "D"
  else:
    "F"
  end 
   
  
where:
  grades(95) is "A"
  grades(85) is "B"
  grades(75) is "C"
  grades(65) is "D"
  grades(45) is "F"
 
end

