class Client::Request
    VALID_CIPHERS = [
        "PLAYFAIR",
        "HILL",
        "VIGENERE",
        "VIGENERE_EXTEND",
        "AUTOKEY_VIGENERE",
        "AFFINE",
        "SUPER"
    ]

    attr_accessor :key, :data, :cipher

    def initialize(key:, data:, cipher:)
        @key = key
        @data = data
        @cipher = cipher.upcase
        validate_attributes
    end

    def validate_attributes
        raise Utils::Exception.new("Fields key, data, and cipher cannot be empty") if key.nil? || data.nil? || cipher.nil?
        raise Utils::Exception.new("Invalid Cipher") unless VALID_CIPHERS.include?(cipher.upcase)
    end

    def decrypt
      case @cipher
      when "VIGENERE"
        Cipher::Vigenere.decrypt(@key, @data)
      when "AUTOKEY_VIGENERE"
        Cipher::AutokeyVigenere.decrypt(@key, @data)
      when "EXTENDED_VIGENERE"
        Cipher::ExtendedVigenere.decrypt(@key, @data)
      when "AFFINE"
        Cipher::Affine.decrypt(@key, Ciphertext::String.new(@data))
      when "PLAYFAIR"
        Cipher::Playfair.decrypt(@key, Ciphertext::String.new(@data))
      when "HILL"
        Cipher::Hill.decrypt(@key, Ciphertext::String.new(@data))
      when "SUPER"
        Cipher::SuperEncryption.decrypt(@key, Ciphertext::String.new(@data))
      else
        raise Utils::Exception.new("Invalid Cipher")
      end
    end

    def encrypt
      case @cipher
      when "PLAYFAIR"
        Cipher::Playfair.encrypt(@key, Plaintext::String.new(@data))
      when "HILL"
        Cipher::Hill.encrypt(@key, Plaintext::String.new(@data))
      when "VIGENERE"
        Cipher::Vigenere.encrypt(@key, @data)
      when "AUTOKEY_VIGENERE"
        Cipher::AutokeyVigenere.encrypt(@key, @data)
      when "EXTENDED_VIGENERE"
        Cipher::ExtendedVigenere.encrypt(@key, @data).dump
      when "AFFINE"
        Cipher::Affine.encrypt(@key, Plaintext::String.new(@data))
      when "SUPER"
        Cipher::SuperEncryption.encrypt(@key, Plaintext::String.new(@data)).dump
      else
        raise Utils::Exception.new("Invalid Cipher")
      end
    end
  end
