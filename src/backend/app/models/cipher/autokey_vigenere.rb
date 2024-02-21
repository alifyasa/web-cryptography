class Cipher::AutokeyVigenere
    @@UPPERCASE_LETTERS = ("A".."Z").to_a
    # Untuk setiap length(key) < length(plaintext), setelah plaintext di lakukan enkrips/dekripsi sepanjang length(key)
    # lanjutkan dengan enkripsi/dekripsi substring plaintext tersebut sendiri mulai dari index pertama
    # Sampai dengan elemen plaintext yang diiterasi selesai di-enkripsi/dekripsi semua
    # untuk enkripsi/dekripsi per letternya menggukana caesar cipher sama seperti vigenere biasa
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
  