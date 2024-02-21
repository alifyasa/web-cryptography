class Cipher::ExtendedVigenere
    def self.encrypt(key,plaintext)
        key = key.split('')
        ciphertext = plaintext.split('').collect do |letter|
            cipherletter = ((letter.ord+key.first.ord)%256).chr;
            key << key.shift
            cipherletter
        end
        return ciphertext.join
    end

    def self.decrypt(key,ciphertext)
        key = key.split('')
        plaintext = ciphertext.split('').collect do |letter|
            plainletter = ((letter.ord-key.first.ord)%256).chr;
            key << key.shift
            plainletter
        end
        return plaintext.join
    end
end