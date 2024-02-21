require 'matrix'

class Cipher::Hill
  def self.key_to_matrix_key(key, block_size)
    if key.length != block_size**2
      raise Utils::Exception.new("Expected key size #{block_size ** 2}, got key size #{key.length}")
    end

    matrix_key = Matrix.build(block_size) { |row, col| encode_char(key[row * block_size + col]) }

    if matrix_key.det == 0
      raise Utils::Exception.new("Key #{key.upcase} is not invertible")
    end

    matrix_key
  end

  def self.encode_char(key_char)
    key_char.upcase.ord - 'A'.ord
  end

  def self.decode_char(num)
    (num % 26 + 'A'.ord).chr
  end

  def self.encrypt(key, data)
    # Validation
    raise Utils::Exception.new("Can only encrypt string") unless data.is_a?(Plaintext::String)
    plaintext = data.to_s
    matrix_key = key_to_matrix_key(key, Math.sqrt(plaintext.length).to_i)

    # Prepare plaintext
    plaintext = plaintext.gsub(/[^a-zA-Z]/, '').upcase
    encoded_plaintext = plaintext.chars.map { |char| encode_char(char) }

    # Padding encoded_plaintext if necessary
    padding_length = matrix_key.row_size - (encoded_plaintext.length % matrix_key.row_size)
    encoded_plaintext += Array.new(padding_length, encode_char('X')) if padding_length != matrix_key.row_size

    # Convert encoded_plaintext to matrix, naming it matrix_plaintext
    matrix_plaintext = Matrix.build(matrix_key.row_size) do |row, col|
      encoded_plaintext[row * matrix_key.row_size + col]
    end

    # Transpose both key and plaintext
    # See https://en.wikipedia.org/wiki/Hill_cipher
    # Menyamakan dengan contoh
    matrix_key = matrix_key.transpose
    matrix_plaintext = matrix_plaintext.transpose

    # Multiply matrix_key with matrix_plaintext
    encrypted_matrix = matrix_key * matrix_plaintext

    # Menyamakan dengan contoh
    encrypted_matrix = encrypted_matrix.transpose

    puts matrix_key, matrix_plaintext, encrypted_matrix

    # return
    encrypted_matrix
      .to_a
      .flatten
      .map { | v_el | decode_char(v_el) }
      .join
  end

end
