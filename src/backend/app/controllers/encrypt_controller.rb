class EncryptController < ApplicationController
    def index
        render json: { message: "Hello World" }
    end

    def create
        begin
          encrypt_request = EncryptRequest.new(
            key: params[:key],
            data: params[:data],
            cipher: params[:cipher]
          )
          # Processing
          render json: EncryptResponse.new(
            data: params[:data],
            message: "Success"
          ).json
        rescue EncryptError => e
            render json: EncryptResponse.new(
                data: nil,
                message: "#{e.message}"
            ).json, status: :bad_request
        rescue StandardError => _
            render json: {
                message: "Server Error"
            }, status: :internal_server_error
        end
    end
end

class EncryptError < StandardError
    attr_accessor :message
    def initialize(message)
        @message = message
        super(message: message)
    end
end

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

class EncryptResponse
    attr_accessor :message, :data

    def initialize(data:, message:)
        @message = message
        @data = data
    end

    def json
        { data: self.data, message: self.message }
    end
end
