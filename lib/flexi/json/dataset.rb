module Flexi::Json
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

    # Returns true if any of the client's fields match the search query
    def matches?(query, fields = searchable_fields)
      valid_fields = fields&.select { |field| searchable_fields.include?(field) } || searchable_fields

      return false if valid_fields.empty?

      valid_fields.any? do |field|
        value = send(field)
        value.to_s.downcase.include?(query.to_s.downcase)
      end
    end

    def searchable_fields
      @searchable_fields ||= attributes.keys.map(&:to_s)
    end

    private

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
