class Cipher::Affine
  def self.coprime?(a, b)
    while b != 0
      a, b = b, a % b
    end
    return a.abs == 1
  end

  def self.extended_gcd(a, b)
    return [0, 1] if a % b == 0

    x, y = extended_gcd(b, a % b)
    [y, x - y * (a / b)]
  end

  def self.mod_inverse(a, m)
    x, _ = extended_gcd(a, m)
    x += m if x < 0
    x
  end

  def self.encrypt(key, data)
    # Validation
    raise Utils::Exception.new("Can only encrypt string.") unless data.is_a?(Plaintext::String)
    unless key =~ /^\d+,\d+$/
      raise Utils::Exception.new("Invalid key format. Please provide the key in the format 'a,b'.")
    end

    plaintext = data.to_s.upcase
    a, b = key.split(',').map(&:to_i)

    unless coprime?(a, 26)
      raise Utils::Exception.new("The coefficient 'a' must be coprime with 26.")
    end

    encrypted_text = ""
    plaintext.each_char do |char|
      if char =~ /[A-Za-z]/
        offset = 'A'.ord
        char_index = char.ord - offset
        encrypted_index = (a * char_index + b) % 26
        encrypted_char = (encrypted_index + offset).chr
        encrypted_text += encrypted_char
      else
        encrypted_text += char
      end
    end

    encrypted_text.upcase
  end

  def self.decrypt(key, data)
    # Validation
    raise Utils::Exception.new("Can only decrypt string.") unless data.is_a?(Ciphertext::String)
    unless key =~ /^\d+,\d+$/
      raise Utils::Exception.new("Invalid key format. Please provide the key in the format 'a,b'.")
    end

    ciphertext = data.to_s.upcase
    a, b = key.split(',').map(&:to_i)

    m_inverse = mod_inverse(a, 26)

    decrypted_text = ""
    ciphertext.each_char do |char|
      if char.match?(/[a-zA-Z]/)
        offset = 'A'.ord

        decrypted_char = ((m_inverse * (char.ord - offset - b)) % 26 + offset).chr
        decrypted_text << decrypted_char
      else
        decrypted_text << char
      end
    end
    decrypted_text
  end
end
