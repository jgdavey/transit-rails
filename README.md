# transit-rails

![Travis status](https://travis-ci.org/jgdavey/transit-rails.svg?branch=master)

Use [transit format](https://github.com/cognitect/transit-format) in
your Rails application, with minimal friction.

Currently only works with C-based Ruby implementations.

## Installation

Add this line to your application's Gemfile:

    gem 'transit-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install transit-rails

## Usage

In your controller:

```ruby
def index
  @posts = Post.all
  respond_to do |format|
    format.html
    format.transit { render transit: @posts }
  end
end
```

## Contributing

1. Fork it ( https://github.com/jgdavey/transit-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
