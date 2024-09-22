require "singleton"
module Flexi
  module Json
    class ConfigError < StandardError; end

    class Configuration
      include Singleton

      attr_accessor :exact_match_search, :match_all_fields

      class << self
        def default_match_options
          {
            match_all: @match_all_fields || false,
            exact_match: @exact_match_search || false
          }.freeze
        end
      end

      def initialize
        @exact_match_search = false
        @match_all_fields = false
      end
    end
  end
end
