# frozen_string_literal: true

require_relative "json/dataset"
require_relative "json/loader"
require_relative "json/searcher"
require_relative "json/version"

module Flexi::Json
  class Error < StandardError; end

  class Run
    # Your code goes here...
    def initialize(data)
      @json_data = Flexi::Json::Loader.new(data).load_data
    end

    def search(query = "", fields = nil)
      Flexi::Json::Searcher.new(@json_data).search(query, fields)
    end

    def find_duplicates(keys)
      Flexi::Json::Searcher.new(@json_data).find_duplicates(keys)
    end
  end
end
