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
        ret += @@UPPERCASE_LETTERS[(@@UPPERCASE_LETTERS.index(plaintext[pos]) + @@UPPERCASE_LETTERS.index(x))%26]
        pos += 1
      end
      pos1 = 0
      while pos<length_plaintext
        ret += @@UPPERCASE_LETTERS[(@@UPPERCASE_LETTERS.index(plaintext[pos]) + @@UPPERCASE_LETTERS.index(plaintext[pos1]))%26]
        pos += 1
        pos1 += 1
      end
      return ret
    end

    # Lakukan logika pembalikan, yaitu kita berusaha melengkapi key dengan plainteks ke-0 sampai dengan ke-k (Pada saat ciphertext selesai diiterasi)
    # Untuk setiap key k-0 sampai ke ke-k, assign menjadi kunci
    # Demikian untuk setiap key, lakukan caesar cipher dgn ciphertext sehingga menghasilkan plaintext yang ingin dicari selesai
    def self.decrypt(key,ciphertext)
      pos = 0
      length_ciphertext = ciphertext.length
      key = key.upcase.split('')
      ciphertext = ciphertext.upcase.split('')
      ret = ""
      for x in key do
        ret += @@UPPERCASE_LETTERS[(@@UPPERCASE_LETTERS.index(ciphertext[pos]) - @@UPPERCASE_LETTERS.index(x))%26]
        pos += 1
      end
      pos1 = 0
      while pos<length_ciphertext
        ret += @@UPPERCASE_LETTERS[(@@UPPERCASE_LETTERS.index(ciphertext[pos]) - @@UPPERCASE_LETTERS.index(ret[pos1]))%26]
        pos += 1
        pos1 += 1
      end
      return ret
    end
  end
  