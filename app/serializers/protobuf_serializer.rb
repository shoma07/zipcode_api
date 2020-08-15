# frozen_string_literal: true

# ProtobufSerializer
class ProtobufSerializer
  INIT_MESSAGE = ->(object) {}
  attr_reader :message

  delegate(:to_proto, :to_h, to: :message)

  class << self
    # @param repeated [Enumerable]
    # @return [Array<Google::Protobuf::MessageExts>]
    def repeated_message(repeated)
      repeated.map { |object| new(object).message }
    end

    # @param object [Object]
    # @return [Google::Protobuf::MessageExts]
    def message(object)
      new(object).message
    end
  end

  # @param object [Object]
  # @return [ProtobufSerializer]
  def initialize(object, options = {})
    @message = self.class::INIT_MESSAGE.call(object)
    @options = options
  end

  # @return [String]
  def to_json(*_args)
    json = message.to_json(emit_defaults: true)
    return json unless options[:pretty]

    JSON.pretty_generate(JSON.parse(json))
  end
end
