# frozen_string_literal: true

require './lib/inflectors/with_protobuf_inflector'

Rails.autoloaders.each do |autoloader|
  autoloader.inflector = Inflectors::WithProtobufInflector.new
end
