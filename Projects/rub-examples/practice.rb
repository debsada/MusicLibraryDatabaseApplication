def say_hello(name)
    return "hello #{name}"
end 


def encode(plaintext, key)
    cipher = key.chars.uniq + (('a'..'z').to_a - key.chars) #nmakes array of alphabet
    ciphertext_chars = plaintext.chars.map do |char|
        (65 + cipher.find_index(char)).chr
    end
    return ciphertext_chars.join
  end
  
  def decode(ciphertext, key)
    cipher = key.chars.uniq + (('a'..'z').to_a - key.chars)
    plaintext_chars = ciphertext.chars.map do |char|
        cipher[char.ord-65]
    end
    return plaintext_chars.join
  end

def get_most_common_letter(text)
    counter = Hash.new(0)
    text.chars.each do |char|
        counter[char] += 1
    end
   counter.delete(" ")
   most_common_word = counter.length
   key_pair = counter.sort_by {|k, v | v} [most_common_word-1]
   return key_pair[0]
    
end 

#   puts say_hello("kay")

#   encode("theswiftfoxjumpedoverthelazydog", "secretkey")
#   puts decode("EMBAXNKEKSYOVQTBJSWBDEMBPHZGJSL", "secretkey")

puts get_most_common_letter("the roof, the roof, the roof is on fire!")