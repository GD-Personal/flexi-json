require "net/http"
require "uri"

module Flexi
  module Json
    class Loader
      def initialize(data)
        @data = data
      end

      def load_data
        loaded_data = load_from_local_file || load_from_raw_json || load_from_url || []
        loaded_data.map { |result| Dataset.new(result.transform_keys(&:to_sym)) }
      end

      private

      def load_from_raw_json(raw_json = nil)
        data = JSON.parse(raw_json || @data)
        data.is_a?(Array) ? data : [data]
      rescue JSON::ParserError, TypeError
        nil
      end

      def load_from_local_file
        data = File.read(@data)
        load_from_raw_json(data)
      rescue Errno::ENOENT, TypeError
        nil
      end

      def load_from_url
        uri = URI.parse(@data)
        response = Net::HTTP.get_response(uri)
        response.is_a?(Net::HTTPSuccess) ? load_from_raw_json(response.body) : nil
      rescue URI::InvalidURIError, Errno::ECONNREFUSED
        nil
      end
    end
  end
end
