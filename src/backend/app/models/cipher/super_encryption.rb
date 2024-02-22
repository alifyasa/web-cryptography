class Cipher::SuperEncryption

    def self.encrypt1(key_trans,key_subs,plaintext)
        encrypt1_letter = Cipher::ExtendedVigenere.encrypt(key_subs,plaintext)
        encrypt1_length = encrypt1_letter.length
        length_row = 0
        if(encrypt1_length%key_trans == 0) 
            length_row = encrypt1_length/key_trans
        else 
            length_row = encrypt1_length/key_trans + 1
        end
        ret = ""
        for column_ind in 0..(key_trans-1) do
            for row_ind in 0..(length_row-1) do
                pos = key_trans*row_ind + column_ind
                if(pos <= encrypt1_length-1)
                    ret += encrypt1_letter[pos]
                end
            end
        end
        return ret
    end

    def self.decrypt1(key_trans,key_subs,decrypt)
        decrypt1_letter = Cipher::ExtendedVigenere.decrypt(key_subs,decrypt)
    end

end