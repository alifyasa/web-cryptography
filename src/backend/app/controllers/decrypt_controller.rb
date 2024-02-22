class DecryptController < ApplicationController
    def index
        render json: { message: "Hello World" }
    end

    def create
        begin
            decrypt_request = Client::Request.new(
                key: params[:key],
                data: params[:data],
                cipher: params[:cipher]
            )
            puts "Key    : #{params[:key]}"
            puts "Data   : #{params[:data]}"
            puts "Cipher : #{params[:cipher]}"
            plaintext = decrypt_request.decrypt
            puts "Result : #{plaintext}"
            render json: Server::Response.new(
                data: plaintext,
                message: "Success"
            ).json
        rescue Utils::Exception => e
            render json: {
                message: e.message
            }, status: :bad_request
        end
    end
end
