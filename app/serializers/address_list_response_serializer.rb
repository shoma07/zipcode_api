# frozen_string_literal: true

# AddressListResponseSerializer
class AddressListResponseSerializer < ProtobufSerializer
  INIT_MESSAGE = lambda do |object|
    Proto::AddressListResponse.new(
      page: PageMetaSerializer.message(object),
      data: AddressSerializer.repeated_message(object)
    )
  end
end
