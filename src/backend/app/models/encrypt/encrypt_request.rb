class EncryptRequest
  VALID_CIPHERS = ["VIGNERE"]

  attr_accessor :key, :data, :cipher

  def initialize(key:, data:, cipher:)
      @key = key
      @data = data
      @cipher = cipher
      validate_attributes
  end

  def validate_attributes
      raise EncryptError.new("Fields key, data, and cipher cannot be empty") if key.nil? || data.nil? || cipher.nil?
      raise EncryptError.new("Invalid Cipher") unless VALID_CIPHERS.include?(cipher)
  end
end
