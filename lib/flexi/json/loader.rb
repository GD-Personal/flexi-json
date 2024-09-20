module Flexi::Json
  class Loader
    def initialize(data_file_path)
      @data_file_path = data_file_path
    end

    def load_data(output = $stdout)
      file = File.read(@data_file_path)
      JSON.parse(file).map { |result| Dataset.new(result) }
    rescue Errno::ENOENT
      output.puts("Dataset file not found at #{@data_file_path}!")
      []
    rescue JSON::ParserError
      output.puts("Invalid JSON!")
      []
    end
  end
end