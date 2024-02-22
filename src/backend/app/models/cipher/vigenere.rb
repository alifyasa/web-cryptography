class Cipher::Vigenere
  @@UPPERCASE_LETTERS = ("A".."Z").to_a
  # Idenya dgn cara menggeser untuk setiap karakter pertama sedemikian sehingga, pengecekannya menjadi circular
  def self.encrypt(key, plaintext)
      key = key.upcase.split('')
      plaintext = plaintext.gsub(/[^a-zA-Z]/, '').upcase
      ciphertext = plaintext.upcase.split('').collect do |letter|
        if @@UPPERCASE_LETTERS.include? letter
          # puts "'#{letter}' -> '#{@@UPPERCASE_LETTERS.index(letter)}', '#{key}' -> '#{@@UPPERCASE_LETTERS.index(key.first)}'"
          cipherletter = @@UPPERCASE_LETTERS[(@@UPPERCASE_LETTERS.index(letter) + @@UPPERCASE_LETTERS.index(key.first))%26]
          # puts cipherletter
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
      ciphertext = ciphertext.gsub(/[^a-zA-Z]/, '').upcase
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