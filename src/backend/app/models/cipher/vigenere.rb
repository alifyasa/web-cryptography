class Cipher::Vigenere
    @@UPPERCASE_LETTERS = ("A".."Z").to_a
    @@LOWERCASE_LETTERS = ("a".."z").to_a

    def self.encrypt(key, plaintext)
        key = key.upcase.split('')

        ciphertext = plaintext.upcase.split('').collect do |letter|
          if @@LOWERCASE_LETTERS.include?(letter) || @@UPPERCASE_LETTERS.include?(letter)
            cipherletter = Cipher::Caesar.encrypt(key.first, letter)
            key << key.shift
          else
            cipherletter = letter
          end
          cipherletter
        end
    
        return ciphertext.join
    end
  
    def self.decode(key, ciphertext)
        key = key.upcase.split('')
    
        plaintext = ciphertext.split('').collect do |cipherletter|
          if @@LOWERCASE_LETTERS.include?(cipherletter) || @@UPPERCASE_LETTERS.include?(cipherletter)
            letter = Cipher::Caesar.decrypt(key.first, cipherletter)
            key << key.shift 
          else
            letter = cipherletter
          end
          letter
        end
    
        return plaintext.join
      end
  end
  