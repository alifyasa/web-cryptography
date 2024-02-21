class Cipher::Vigenere
    @@UPPERCASE_LETTERS = ("A".."Z").to_a
    # Idenya dgn cara menggeser untuk setiap karakter pertama sedemikian sehingga, pengecekannya menjadi circular
    def self.encrypt(key, plaintext)
        key = key.upcase.split('')
        ciphertext = plaintext.upcase.split('').collect do |letter|
          if @@UPPERCASE_LETTERS.include? letter
            cipherletter = @@UPPERCASE_LETTERS[(@@UPPERCASE_LETTERS.index(letter) + @@UPPERCASE_LETTERS.index(key.first))%26]
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
        plaintext = ciphertext.upcase.split('').collect do |cipherletter|
          if @@UPPERCASE_LETTERS.include? cipherletter
            letter = @@UPPERCASE_LETTERS[(@@UPPERCASE_LETTERS.index(cipherletter) - @@UPPERCASE_LETTERS.index(key.first))%26]
            key << key.shift
          else
            letter = cipherletter
          end
          letter
        end
        return plaintext.join
      end
  end
  