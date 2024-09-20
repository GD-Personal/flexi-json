module JsonSearchCli
  class Dataset
    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes

      @attributes.each do |key, value|
        # Validate that the key is a valid Ruby method name
        if valid_key?(key)
          # Create instance variables safely
          instance_variable_set(:"@#{key}", value)

          # Define getter and setter methods dynamically
          self.class.class_eval do
            define_method(key) { instance_variable_get(:"@#{key}") } unless method_defined?(key)
            define_method(:"#{key}=") { |val| instance_variable_set(:"@#{key}", val) } unless method_defined?(:"#{key}=")
          end
        else
          raise "Invalid key: #{key}"
        end
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

    private

    def searchable_fields
      @searchable_fields ||= attributes.keys.map(&:to_s)
    end

    # Method to validate that a key is a valid method name and not dangerous
    def valid_key?(key)
      key.match?(/\A[a-z_][a-zA-Z0-9_]*\z/) && !dangerous_method?(key)
    end

    # Prevent overriding critical Ruby methods
    def dangerous_method?(key)
      %w[initialize object_id method_missing to_s send class].include?(key.to_s)
    end
  end
end