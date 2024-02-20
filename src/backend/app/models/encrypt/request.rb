class Encrypt::Request
  VALID_CIPHERS = [
    "PLAYFAIR",
    "HILL"
]

  attr_accessor :key, :data, :cipher

  def initialize(key:, data:, cipher:)
      @key = key
      @data = data
      @cipher = cipher.upcase
      validate_attributes
  end

  def validate_attributes
      raise Encrypt::Exception.new("Fields key, data, and cipher cannot be empty") if key.nil? || data.nil? || cipher.nil?
      raise Encrypt::Exception.new("Invalid Cipher") unless VALID_CIPHERS.include?(cipher.upcase)
  end

  def encrypt
    case @cipher
    when "PLAYFAIR"
      Cipher::Playfair.encrypt(@key, Plaintext::String.new(@data))
    when "HILL"
      Cipher::Hill.encrypt(@key, Plaintext::String.new(@data))
    else
      raise Encrypt::Exception.new("Invalid Cipher")
    end
  end
end
