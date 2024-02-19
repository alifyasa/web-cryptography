class Encrypt::Request
  VALID_CIPHERS = [
    "PLAYFAIR"
]

  attr_accessor :key, :data, :cipher

  def initialize(key:, data:, cipher:)
      @key = key
      @data = data
      @cipher = cipher
      validate_attributes
  end

  def validate_attributes
      raise Encrypt::Exception.new("Fields key, data, and cipher cannot be empty") if key.nil? || data.nil? || cipher.nil?
      raise Encrypt::Exception.new("Invalid Cipher") unless VALID_CIPHERS.include?(cipher.upcase)
  end

  def encrypt
    Cipher::Playfair.encrypt(@key, Plaintext::String.new(@data))
  end
end
