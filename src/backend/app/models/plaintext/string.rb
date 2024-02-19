# Enumerable per-character
class Plaintext::String < Plaintext::Base
  include Enumerable

  def each
    @data.each_char { |char| yield char }
  end

  def to_s
    @data
  end
end
