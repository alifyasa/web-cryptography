class Cipher::AutokeyVigenere
    @@UPPERCASE_LETTERS = ("A".."Z").to_a
    @@LOWERCASE_LETTERS = ("a".."z").to_a

    def self.encrypt(key, plaintext)
        key = key.upcase.split('')
        # Idenya dgn cara menggeser untuk setiap karakter pertama sedemikian sehingga, pengecekannya menjadi circular
        ciphertext = plaintext.split('').collect do |letter|
          if @@UPPERCASE_LETTERS.include? letter
            cipherletter = Cipher::Caesar.encrypt(@@UPPERCASE_LETTERS.index(key.first), letter)
            key << key.shift
          elsif @@LOWERCASE_LETTERS.include? letter
            cipherletter = Cipher::Caesar.encrypt(@@UPPERCASE_LETTERS.index(key.first), letter)
            key << key.shift
          else
            cipherletter = letter
          end
          cipherletter
        end
    
        return ciphertext.join
    end
  
    def self.decrypt(key, ciphertext)
        key = key.upcase.split('')
        # Idenya dgn cara menggeser untuk setiap karakter pertama sedemikian sehingga, pengecekannya menjadi circular
        plaintext = ciphertext.split('').collect do |cipherletter|
          if @@UPPERCASE_LETTERS.include? cipherletter
            letter = Cipher::Caesar.decrypt(@@UPPERCASE_LETTERS.index(key.first), cipherletter)
            key << key.shift 
          elsif @@LOWERCASE_LETTERS.include? cipherletter
            letter = Cipher::Caesar.decrypt(@@UPPERCASE_LETTERS.index(key.first), cipherletter)
            key << key.shift
          else
            letter = cipherletter
          end
          letter
        end
    
        return plaintext.join
      end
  end
  