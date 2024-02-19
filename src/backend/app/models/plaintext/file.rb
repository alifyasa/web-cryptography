# Enumerable per-byte
class Plaintext::File < Plaintext::Base
  include Enumerable

  def each
    File.open(@data, "r") do |file|
      file.each_byte { |byte| yield byte }
    end
  end
end
