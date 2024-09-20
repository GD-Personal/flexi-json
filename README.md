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
require 'flexi-json'

# File path to the JSON data
file_path = "some/path/to/file.json"

# Parse JSON and search for a user
data = Flexi::Json::Loader.new(file_path).load_data

searcher = Flexi::Json::Seacher.new(data)

# Search for data
searcher.search("john")

# Or filter it by your chosen key e.g first_name
searcher.search("john", "first_name")

# Find duplicate emails
seacher.find_duplicate_emails
```
## TODOS
- Improve search filter by specifying fields to filter from
- Improve the find_duplicate function by adding ability to find duplciates based on a selected field
- Add support for accepting a dataset url rather than just a local file path
- Add support for accepting raw json data
- Add CRUD support to the dataset
- Optimise the search function by implimenting indeces
- Optimise the loader by chunking the data

## Contributing
Contributions are welcome! If you have suggestions for improvements or new features, feel free to fork the repository and create a pull request. Please ensure your code adheres to the project's coding standards and includes tests for new features.

Bug reports and pull requests are welcome on GitHub at https://github.com/GD-Personal/flexi-json. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/GD-Personal/flexi-json/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
