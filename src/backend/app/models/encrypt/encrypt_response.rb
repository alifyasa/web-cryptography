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
