class EncryptController < ApplicationController
    def index
        render json: { message: "Hello World" }
    end

    def create
        begin
          # Validation
          encrypt_request = Client::Request.new(
            key: params[:key],
            data: params[:data],
            cipher: params[:cipher]
          )
          puts "Key    : #{params[:key]}"
          puts "Data   : #{params[:data]}"
          puts "Cipher : #{params[:cipher]}"
          # Processing
          ciphertext = encrypt_request.encrypt
          puts "Result : #{ciphertext}"
          # Output
          render json: Server::Response.new(
            data: ciphertext,
            message: "Success"
          ).json
        rescue Utils::Exception => e
            render json: {
                message: e.message
            }, status: :bad_request
        end
    end
end
