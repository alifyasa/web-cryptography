class Cipher::Caesar
    @@UPPERCASE_LETTERS = ("A".."Z").to_a
    @@LOWERCASE_LETTERS = ("a".."z").to_a
  
    def self.encrypt(key,text)
      ret = ""
      text.split("").to_a.each do |letter|
        if @@LOWERCASE_LETTERS.include? letter
            ret += @@LOWERCASE_LETTERS[ (@@LOWERCASE_LETTERS.index(letter) + key) % 26]
        elsif @@UPPERCASE_LETTERS.include? letter
            ret += @@UPPERCASE_LETTERS[ (@@UPPERCASE_LETTERS.index(letter) + key) % 26]
        else
            ret += letter
        end
      end
      return ret
    end
  
  
    def self.decrypt(key,text)
      ret = ""
      text.split("").to_a.each do |letter|
        if @@LOWERCASE_LETTERS.include? letter
            ret += @@LOWERCASE_LETTERS[ (@@LOWERCASE_LETTERS.index(letter) - key) % 26]
        elsif @@UPPERCASE_LETTERS.include? letter
            ret += @@UPPERCASE_LETTERS[ (@@UPPERCASE_LETTERS.index(letter) - key) % 26]
        else
            ret += letter
        end
      end
      return ret
    end
  end