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
            render json: {
                message: e.message
            }, status: :bad_request
        rescue StandardError => _
            render json: {
                message: "Server Error"
            }, status: :internal_server_error
        end
    end
end
