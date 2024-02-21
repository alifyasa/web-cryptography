class Cipher::AutokeyVigenere
    @@UPPERCASE_LETTERS = ("A".."Z").to_a

    def self.encrypt(key,plaintext)
      pos = 0
      length_plaintext = plaintext.length
      key = key.upcase.split('')
      plaintext = plaintext.upcase.split('')
      ret = ""
      for x in key do
        ret += Cipher::Caesar.encrypt(@@UPPERCASE_LETTERS.index(x) ,plaintext[pos])
        pos += 1
      end
      pos1 = 0
      while pos<length_plaintext
        ret += Cipher::Caesar.encrypt(@@UPPERCASE_LETTERS.index(plaintext[pos1]) ,plaintext[pos])
        pos += 1
        pos1 += 1
      end
      return ret
    end

    def self.decrypt(key,plaintext)
      pos = 0
      length_plaintext = plaintext.length
      key = key.upcase.split('')
      plaintext = plaintext.upcase.split('')
      ret = ""
      for x in key do
        ret += Cipher::Caesar.decrypt(@@UPPERCASE_LETTERS.index(x) ,plaintext[pos])
        pos += 1
      end
      pos1 = 0
      while pos<length_plaintext
        ret += Cipher::Caesar.decrypt(@@UPPERCASE_LETTERS.index(plaintext[pos1]) ,plaintext[pos])
        pos += 1
        pos1 += 1
      end
      return ret
    end
  end
  