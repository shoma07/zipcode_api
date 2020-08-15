# frozen_string_literal: true

module Inflectors
  # Inflectors::WithProtobufInflector
  class WithProtobufInflector < Zeitwerk::Inflector
    # @param [String] basename
    # @param [String] abspath
    # @return [String]
    def camelize(basename, abspath)
      /\A[a-z_]+_pb\z/.match?(basename) ? basename.gsub('_pb', '').camelize : super
    end
  end
end
