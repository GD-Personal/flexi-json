require "json"

module Flexi::Json
  class Searcher
    attr_reader :data

    def initialize(data)
      @data = data
      @result = []
    end

    def search(query, fields = nil)
      @data.select { |data| data.matches?(query, fields) }
    end

    def find_duplicate_emails
      duplicates = {}

      data_by_email = @data.group_by { |d| d.email.downcase }
      data_by_email.each do |key, value|
        duplicates[key] = value if value.size > 1
      end

      duplicates.values.flatten
    end

    # Displays results to the console
    def display_results(results, output = $stdout)
      if results.empty?
        output.puts "No data found."
      else
        results.each do |result|
          output.puts result.attributes.map { |k, v| "#{k}: #{v}" }.join(", ")
        end
        output.puts "Found #{results.size} result(s)!"
      end
    end
  end
end
