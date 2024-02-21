class Cipher::Affine
  def self.encrypt(key, data)
    # Validation
    raise Utils::Exception.new("Can only encrypt string") unless data.is_a?(Plaintext::String)
    unless key =~ /^\d+,\d+$/
      raise Utils::Exception.new("Invalid key format. Please provide the key in the format 'a,b'.")
    end

    plaintext = data.to_s.upcase
    a, b = key.split(',').map(&:to_i)
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
end
