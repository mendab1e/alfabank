# Alfabank

[![Build Status](https://travis-ci.org/mendab1e/alfabank.svg?branch=master)](https://travis-ci.org/mendab1e/alfabank) [![Gem Version](https://badge.fury.io/rb/alfabank.svg)](https://badge.fury.io/rb/alfabank)

This gem provides support for the API of [Alfabank acquiring gateway](https://engine.paymentgate.ru/ecommerce/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alfabank'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alfabank

## Usage

Configure the gem with the credentials provided by the bank. If you are using Ruby on Rails, you should do that in an initializer.

```ruby
# config/initializers/alfabank.rb
Alfabank.configure do |config|
  config.userName = Rails.application.credentials.dig(:alfabank, :userName)
  config.password = Rails.application.credentials.dig(:alfabank, :password)
  config.environment = Rails.application.credentials.dig(:alfabank, :environment) # 'production' or 'test'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mendab1e/alfabank.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
