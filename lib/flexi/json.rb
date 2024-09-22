# frozen_string_literal: true

require_relative "json/configuration"
require_relative "json/dataset"
require_relative "json/loader"
require_relative "json/searcher"
require_relative "json/version"

module Flexi::Json
  class << self
    attr_writer :configuration

    # Access or initialize the configuration object
    def configuration
      @configuration ||= Flexi::Json::Configuration.instance
    end

    # Configure block for setting custom configurations
    def configure
      yield(configuration)
    end
  end

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
  end
end
