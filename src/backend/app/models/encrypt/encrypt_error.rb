class EncryptError < StandardError
  attr_accessor :message
  def initialize(message)
      @message = message
      super(message: message)
  end
end
