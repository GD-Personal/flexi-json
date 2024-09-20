[![Gem Version](https://badge.fury.io/rb/flexi-json.svg)](https://badge.fury.io/rb/flexi-json) [![Github Actions](https://github.com/GD-Personal/flexi-json/actions/workflows/main.yml/badge.svg)](https://github.com/GD-Personal/flexi-json/actions/workflows/main.yml) [![Maintainability](https://api.codeclimate.com/v1/badges/bd14f8a5a0c7575d2ac2/maintainability)](https://codeclimate.com/github/GD-Personal/flexi-json/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/bd14f8a5a0c7575d2ac2/test_coverage)](https://codeclimate.com/github/GD-Personal/flexi-json/test_coverage)

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

# Load a json data from a local file
flexi_json = Flexi::Json::Run.new("some/path/to/file.json")

# Load a raw json data
flexi_json = Flexi::Json::Run.new("{\"name\":\"John\",\"address\":\"Sydney Australia\"}")

# Load a json data from aurl
flexi_json = Flexi::Json::Run.new("https://raw.githubusercontent.com/GD-Personal/flexi-json/main/spec/data/dataset.json")

# Search for data
flexi_json.search("john")

# Or filter it by your chosen key e.g first_name
flexi_json.search("john", "first_name")
flexi_json.search("john", "first_name,email")

# Find duplicate emails
flexi_json.find_duplicates("email")
flexi_json.find_duplicates("email,full_name")
```

## TODOS
- Improve search filter by specifying fields to filter from
- Add CRUD support to the dataset
- Optimise the search function by implementing indeces 
- Optimise the loader by chunking the data

## Contributing
Contributions are welcome! If you have suggestions for improvements or new features, feel free to fork the repository and create a pull request. Please ensure your code adheres to the project's coding standards and includes tests for new features.

Bug reports and pull requests are welcome on GitHub at https://github.com/GD-Personal/flexi-json. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/GD-Personal/flexi-json/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
