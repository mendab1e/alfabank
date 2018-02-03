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

Generate initializer,  model and migration:

    $ rails g alfabank Payment

Run migration

    $ rake db:migrate

Set credentials and other options in  `config/initializers/alfabank.rb`

* Use `#register` to register a new order and obtain a payment form url.

* Use `#check_status` to get information about an order.

Create a method to handle status request in your controller and insert a url for this method as a `return_url` param in `config/initializers/alfabank.rb`. Use `#check_status[:order_status]` to determine the status of an order and display it.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mendab1e/alfabank.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

