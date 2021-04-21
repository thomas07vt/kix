# Kix

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/kix`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kix'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install kix

## Usage

```ruby
  class UserSerializer < Kix::Serializer
    attributes :name, :email, :phone, :skippable

    def phone
      _object.phone_number || "N/A"
    end

    def skippable
      # throw skip if you want to omit this attribute entirely
      throw(:skip)
    end
  end

  class User
    include Kix::Serializable
    attr_reader :name, :email, :phone_number

    def initialize(name, email, phone_number = nil)
      @name = name
      @email = email
      @phone_number = phone_number
    end
  end
```

```ruby
User.new("John", "john@example.com").as_json
#=> {"name"=>"John", "email"=>"john@example.com", "phone"=>"N/A"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kix.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
