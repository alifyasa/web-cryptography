class Cipher::SuperEncryption

    def self.encrypt(key, data)

        # Pattern match and split the key
        matches = key.match(/^\s*([^,\s]+)\s*,\s*(\d+)\s*$/)

        # Check if the match was successful
        if matches.nil?
            raise Utils::Exception.new("Invalid key format. Please provide the key in the format 'a,b'.")
        end

        key_subs = matches[1]
        key_trans = matches[2].to_i

        plaintext = data.to_s

        encrypt1_letter = Cipher::ExtendedVigenere.encrypt(key_subs,plaintext)
        puts encrypt1_letter.dump
        encrypt1_length = encrypt1_letter.length
        length_row = encrypt1_length/key_trans
        if(encrypt1_length%key_trans != 0)
            length_row += 1
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
        puts ret.dump
        return ret
    end

    def self.decrypt(key,data)
        # Pattern match and split the key
        matches = key.match(/^\s*([^,\s]+)\s*,\s*(\d+)\s*$/)

        # Check if the match was successful
        if matches.nil?
            raise Utils::Exception.new("Invalid key format. Please provide the key in the format 'a,b'.")
        end

        key_subs = matches[1]
        key_trans = matches[2].to_i

        ciphertext = data.to_s

        ciphertext_length = ciphertext.length
        length_col = ciphertext_length/key_trans
        if(ciphertext_length%key_trans != 0)
            length_col += 1
        end
        ret = ""
        row_batas = ciphertext_length%key_trans
        for column_ind in 0..(length_col-1) do
            for row_ind in 0..(key_trans-1) do
                pos = length_col*row_ind + column_ind
                if(key_trans*column_ind+row_ind < ciphertext_length)
                    if(row_batas > 0 && row_ind-row_batas > 0)
                        ret += ciphertext[pos-(row_ind-row_batas)]
                    else
                        ret += ciphertext[pos]
                    end
                end
            end
        end
        decrypt1_letter = Cipher::ExtendedVigenere.decrypt(key_subs,ret)
        return decrypt1_letter
    end
end