require '../lib/passw'

puts "Basics:\n"

# Generate a secure password of 12 characters in length
Passw.generate(12) 

# Options available for the passwork generation
Passw.generate(12, {
  lowercase:  true, # Allow lower case characters
  uppercase:  true, # Allow uppercase characters
  symbols:    true, # Allow symbols
  numbers:    true, # Allow numbers 
  duplicates: true  # Allow characters to be duplicated (less secure if true)	
})