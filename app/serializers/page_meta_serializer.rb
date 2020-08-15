# frozen_string_literal: true

# PageMetaSerializer
class PageMetaSerializer < ProtobufSerializer
  # @param object [Kaminari::ActiveRecordExtension]
  # @return [Proto::PageMeta]
  INIT_MESSAGE = lambda do |object|
    Proto::PageMeta.new(
      total: object.total_count,
      number: object.current_page,
      size: object.limit_value
    )
  end
end
