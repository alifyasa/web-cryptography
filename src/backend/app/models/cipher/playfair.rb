class Cipher::Playfair

  def self.encrypt(key, data)
    # Validation
    raise Utils::Exception.new("Can only encrypt string") unless data.is_a?(Plaintext::String)
    plaintext = data.to_s

    # Prepare plaintext
    plaintext = plaintext.gsub(/[^a-zA-Z]/, '').upcase
    plaintext += 'X' if plaintext.length.odd?

    # Prepare key
    key = generate_key(key)
    key_index = generate_key_index(key)

    # Encryption
    ciphertext = ''
    (0...plaintext.length).step(2) do |i|
      pair = plaintext[i, 2]
      if pair[0] == pair[1]  # If the two letters are the same, insert a filler letter
        pair[1] = 'X'
      end
      row1, col1 = key_index[pair[0]]
      row2, col2 = key_index[pair[1]]
      if row1 == row2  # Same row, shift columns to the right (circular)
        ciphertext += key[row1][(col1 + 1) % 5]
        ciphertext += key[row2][(col2 + 1) % 5]
      elsif col1 == col2  # Same column, shift rows down (circular)
        ciphertext += key[(row1 + 1) % 5][col1]
        ciphertext += key[(row2 + 1) % 5][col2]
      else  # Form a rectangle, swap column indices
        ciphertext += key[row1][col2]
        ciphertext += key[row2][col1]
      end
    end

    ciphertext
  end

  def self.decrypt(key, data)
    # Validation
    raise Utils::Exception.new("Can only decrypt string") unless data.is_a?(Ciphertext::String)
    ciphertext = data.to_s

    # Prepare plaintext
    ciphertext = ciphertext.gsub(/[^a-zA-Z]/, '').upcase

    # Prepare key
    key = generate_key(key)
    key_index = generate_key_index(key)

    # Decrypt
    plaintext = ''
    ciphertext.chars.each_slice(2) do |pair|
      pair[0], pair[1] = pair[1], pair[0] if pair[0] == pair[1]
      row1, col1 = key_index[pair[0]]
      row2, col2 = key_index[pair[1]]
      if row1 == row2
        plaintext += key[row1][(col1 - 1) % 5] + key[row2][(col2 - 1) % 5]
      elsif col1 == col2
        plaintext += key[(row1 - 1) % 5][col1] + key[(row2 - 1) % 5][col2]
      else
        plaintext += key[row1][col2] + key[row2][col1]
      end
    end

    plaintext
  end

  def self.generate_key_index(key)
    key_index = {}
    key.each_with_index do |row, i|
      row.each_with_index do |letter, j|
        key_index[letter] = [i, j]
      end
    end
    key_index
  end

  def self.generate_key(key)
    # Remove spaces
    key = key.gsub(/[^a-zA-Z]/, '').upcase
    # Remove duplicate characters
    key = key.chars.uniq.join

    # Fill Playfair matrix
    playfair_matrix = []
    key.each_char do |char|
      next if char == 'J'
      playfair_matrix << char
    end
    # Fill with the rest of the character
    ('A'..'Z').each do |char|
      next if char == 'J' || key.include?(char)
      playfair_matrix << char
    end

    # Split to group of 5
    playfair_matrix = playfair_matrix.each_slice(5).to_a
    playfair_matrix
  end
end
