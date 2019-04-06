module Passw
  # Generate a password with the sepecified options
  # Params:
  # +length+:: the length of the password
  # +options+:: a hash defining the attributes for the password
  def self.generate(length, options = {})
    defaults = {
      lowercase:  true,
      uppercase:  true,
      symbols:    true,
      numbers:    true,
      duplicates: true
    }
    
    defaults.merge!(options)
    
    buffer = []
    
    buffer += lowercase if defaults[:lowercase]
    buffer += uppercase if defaults[:uppercase]
    buffer += symbols   if defaults[:symbols]
    buffer += numbers   if defaults[:numbers]   
    
    base = []
    
    (0...length).each do |i|
      if defaults[:deplicates]
        base << buffer[srand % buffer.length]
      else
        loop do
          candidate = buffer[srand % buffer.length]
          
          if !base.include? candidate
            base << candidate
            break
          end
        end
      end
    end
    
    base.shuffle.join
  end

  private 

  def self.symbols
    %w[! " ' # $ % & % ( ) * + , - . / : ; < = > ? ` ~ { | }]
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

puts Passw.generate(10)