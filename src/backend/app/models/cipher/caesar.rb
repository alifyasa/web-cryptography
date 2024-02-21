class Cipher::Caesar
    @@UPPERCASE_LETTERS = ("A".."Z").to_a
  
    def self.encrypt(key,letter)
      ret = ""
      if @@UPPERCASE_LETTERS.include? letter
          ret += @@UPPERCASE_LETTERS[ (@@UPPERCASE_LETTERS.index(letter) + key) % 26]
      else
          ret += letter
      end
      return ret
    end
  
  
    def self.decrypt(key,letter)
      ret = ""
      if @@UPPERCASE_LETTERS.include? letter
          ret += @@UPPERCASE_LETTERS[ (@@UPPERCASE_LETTERS.index(letter) - key) % 26]
      else
          ret += letter
      end
      return ret
    end
  end