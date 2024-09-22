module Flexi
  module Json
    class Dataset
      attr_reader :attributes

      def initialize(attributes = {})
        @attributes = attributes
        @attributes.each do |key, value|
          validate_key(key)
          set_instance_variable(key, value)
          define_accessor_methods(key)
        end
      end

      def matches?(query, fields = nil, options: nil)
        options ||= Flexi::Json::Configuration.default_match_options

        valid_fields = validateable_fields(query, fields)&.select do |field|
          searchable_fields.include?(field)
        end || searchable_fields

        return false if valid_fields.empty?

        matching_method = options[:match_all] ? :all? : :any?
        valid_fields.public_send(matching_method) do |field|
          search_query = query.is_a?(Hash) ? query[field.to_sym] : query
          attribute_value = attributes[field.to_sym].to_s.downcase
          query_value = search_query.to_s.downcase

          options[:exact_match] ? attribute_value == query_value : attribute_value.include?(query_value)
        end
      end

      def searchable_fields
        @searchable_fields ||= attributes.keys.map(&:to_s)
      end

      private

      def validateable_fields(query, fields)
        if query.is_a?(Hash)
          query.keys.map(&:to_s)
        elsif fields.is_a?(String)
          fields.delete(" ").split(",")
        elsif fields.is_a?(Array)
          [fields || searchable_fields].flatten
        end
      end

      # Method to validate that a key is a valid method name and not dangerous
      def valid_key?(key)
        key.match?(/\A[a-z_][a-zA-Z0-9_]*\z/) && !dangerous_method?(key)
      end

      # Prevent overriding critical Ruby methods
      def dangerous_method?(key)
        %w[initialize object_id method_missing to_s send class].include?(key.to_s)
      end

      def validate_key(key)
        raise "Invalid key: #{key}" unless valid_key?(key)
      end

      def set_instance_variable(key, value)
        instance_variable_set(:"@#{key}", value)
      end

      def define_accessor_methods(key)
        self.class.class_eval do
          define_method(key) { instance_variable_get(:"@#{key}") } unless method_defined?(key)
          define_method(:"#{key}=") { |val| instance_variable_set(:"@#{key}", val) } unless method_defined?(:"#{key}=")
        end
      end
    end
  end
end
