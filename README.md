[![Gem Version](https://img.shields.io/gem/v/flexi-json.svg)](https://rubygems.org/gems/flexi-json)
[![Github Actions](https://github.com/GD-Personal/flexi-json/actions/workflows/ci.yml/badge.svg)](https://github.com/GD-Personal/flexi-json/actions)
[![Maintainability](https://api.codeclimate.com/v1/badges/bd14f8a5a0c7575d2ac2/maintainability)](https://codeclimate.com/github/GD-Personal/flexi-json/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/bd14f8a5a0c7575d2ac2/test_coverage)](https://codeclimate.com/github/GD-Personal/flexi-json/test_coverage)

# flexi-json

`Flexi::Json` is a versatile Ruby gem designed for manipulating JSON data. With functionalities for searching, generating new JSON, and transforming existing structures.

## Installation

You can install the gem using RubyGems:
```
gem install flexi-json
```

or add it to your Gemfile
```
gem 'flexi-json'
```

and then run:
```
bundle install
```

## Usage
```ruby
require 'flexi/json'

# Load a raw json data
flexi_json = Flexi::Json.new("{\"name\":\"John\",\"address\":\"Sydney Australia\"}")
# => <Flexi::Json:0x0000ffffa0f5fc58 @datasets=[#<Flexi::Json::Dataset:0x0000ffffa0f5f668 @address="Sydney Australia", @attributes={:name=>"John", :address=>"Sydney Australia"}, @name="John", @searchable_fields=["name", "address"]>]>

# Load a json data from a local file
flexi_json = Flexi::Json.new("some/path/to/file.json")

# Load a json data from a url
flexi_json = Flexi::Json.new("https://raw.githubusercontent.com/GD-Personal/flexi-json/main/spec/data/dataset.json")

# Search for data
flexi_json.search("john")
# => [#<Flexi::Json::Dataset:0x0000ffffa0f5f668 @address="Sydney Australia", @attributes={:name=>"John", :address=>"Sydney Australia"}, @name="John", @searchable_fields=["name", "address"]>]

# Or filter it by your chosen key e.g first_name
flexi_json.search("john", "first_name")
flexi_json.search("john", "first_name,email")

# Find duplicate emails
flexi_json.find_duplicates("email")
flexi_json.find_duplicates("email,full_name")
```

## Advanced search
```ruby
search_query = {first_name: "john", address: "sydney"}
flexi_json.search(
  search_query, 
  options: {matched_all: true, exact_match: false}
)
# => [#<Flexi::Json::Dataset:0x0000ffffa0f5f668 @address="Sydney Australia", @attributes={:name=>"John", :address=>"Sydney Australia"}, @name="John", @searchable_fields=["name", "address"]>]
```

## Configuration
```ruby
Flexi::Json.configure do |config|
  config.exact_match_search = true
  config.match_all_fields = true
end
```

## TODOS
- Generate results in json, csv, txt, or output in the console
- Add CRUD support to the dataset
- Optimise the search function by implementing indeces 
- Optimise the loader by chunking the data

## Contributing
Contributions are welcome! If you have suggestions for improvements or new features, feel free to fork the repository and create a pull request. Please ensure your code adheres to the project's coding standards and includes tests for new features.

Bug reports and pull requests are welcome on GitHub at https://github.com/GD-Personal/flexi-json. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/GD-Personal/flexi-json/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
