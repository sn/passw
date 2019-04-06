module Passw
  # Generate a password with the sepecified options
  # Params:
  # +length+:: the length of the password
  # +options+:: a hash defining the attributes for the password
  def self.generate(length, options = {})
    defaults = {
      lowercase:  true, # Allow lower case characters
      uppercase:  true, # Allow uppercase characters
      symbols:    true, # Allow symbols
      numbers:    true, # Allow numbers 
      duplicates: true  # Allow characters to be duplicated (less secure if true)
    }
    
    defaults.merge!(options)
    
    buffer = []
    
    buffer += lowercase if defaults[:lowercase]
    buffer += uppercase if defaults[:uppercase]
    buffer += symbols   if defaults[:symbols]
    buffer += numbers   if defaults[:numbers]
    
    base = []
    
    buffer_length = buffer.length

    (0...length.to_i).each do |i|
      if defaults[:duplicates]
        base << buffer[srand % buffer_length]
      else
        loop do
          candidate = buffer[srand % buffer_length]
          
          if !base.include? candidate
            base << candidate
            break
          end
          
          # Ensure that this loop does not run forever if duplicates are disallowed
          # In this case, we're limited to the collective size of buffered characters
          
          break if base.length == buffer_length - 1
        end
      end
    end
    
    base.shuffle.join
  end

  private 

  def self.symbols
    %w[! " ' # $ % & ( ) * + , - . / : ; < = > ? ` ~ { | } @ ^]
  end

  def self.lowercase
    %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
  end  

  def self.uppercase
    %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
  end    

  def self.numbers
    %w[0 1 2 3 4 5 6 7 8 9]
  end
end