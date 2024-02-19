class EncryptController < ApplicationController
    def index
        render json: { message: "Hello World" }
    end

    def create
        begin
          # Validation
          encrypt_request = Encrypt::Request.new(
            key: params[:key],
            data: params[:data],
            cipher: params[:cipher]
          )
          # Processing
          ciphertext = encrypt_request.encrypt
          # Output
          render json: Encrypt::Response.new(
            data: ciphertext,
            message: "Success"
          ).json
        rescue Encrypt::Error => e
            render json: {
                message: e.message
            }, status: :bad_request
        end
    end
end
