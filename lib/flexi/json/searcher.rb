require "json"

module Flexi
  module Json
    class Searcher
      attr_reader :data, :result

      def initialize(data)
        @data = data
        @result = []
      end

      def search(query, fields = nil, options: nil)
        @result = @data.select { |data| data.matches?(query, fields, options: options) }
      end

      def find_duplicates(keys)
        duplicates = {}
        fields = keys.gsub(/\s+/, "").strip.split(",")
        filtered_fields = fields.select { |field| @data.first&.searchable_fields&.include?(field) }

        return [] if filtered_fields.empty?

        grouped_data = @data.group_by do |d|
          filtered_fields.map { |f| d.attributes[f.to_sym].to_s.downcase }
        end
        grouped_data.each do |key, value|
          duplicates[key] = value if value.size > 1
        end

        @result = duplicates.values.flatten
      end

      # Displays results to the console
      def display_results(results = @result, output = $stdout)
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
end
