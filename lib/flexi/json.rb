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
      datasets = Flexi::Json::Loader.new(data).load_data
      @searcher = Flexi::Json::Searcher.new(datasets)
    end

    def search(query = "", fields = nil)
      @searcher.search(query, fields)
    end

    def find_duplicates(keys)
      @searcher.find_duplicates(keys)
    end

    def display_results
      @searcher.display_results
    end
  end
end
