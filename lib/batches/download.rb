# frozen_string_literal: true

require 'net/http'
require 'zip'
module Batches
  # Batches::Download
  module Download
    class << self
      # @param [String] filename
      # @return [Integer]
      def execute(filename)
        File.write(filename, ken_all_csv)
      end

      private

      # @return [String]
      def ken_all_csv
        Zip::File.open_buffer(StringIO.new(Net::HTTP.get_response(
          URI.parse(
            'https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip'
          )
        ).body)).first.get_input_stream.read.encode('UTF-8', 'CP932')
      end
    end
  end
end
