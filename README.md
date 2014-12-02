# Custom Logger 1.0.0

Custom logger allows you to log you're debug infmration to an html file so you can
view them in much more easier way. This is my first gem so expect things not
to be perfect.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'customlogger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install customlogger

## Usage

Custom Logger is very easy to use.

#### Log error

    CustomLogger.error 'This is an error message'
    CustomLogger.error = 'This is an error message'
    CustomLogger.error 'This is an error message', 'Error Title'

#### Log warning

    CustomLogger.warning 'This is an warning message'
    CustomLogger.warning = 'This is an warning message'
    CustomLogger.warning 'This is an warning message', 'Warning Title'

#### Log debug

    CustomLogger.debug 'This is an debug message'
    CustomLogger.debug = 'This is an debug message'
    CustomLogger.debug 'This is an debug message', 'Debug Title'

#### Log info

    CustomLogger.info 'This is an info message'
    CustomLogger.info = 'This is an info message'
    CustomLogger.info 'This is an info message', 'Info Title'

#### Log raw

    CustomLogger.raw 'This is an raw message'
    CustomLogger.raw = 'This is an raw message'
    CustomLogger.raw 'This is an raw message', 'Raw Title'

#### Clear All Logs

    customlogger.clear


## Log File

You will find the log file in:

    log/customlogger.html


## Running Test

    bundle exec rake spec

## Contributing

1. Fork it ( https://github.com/[my-github-username]/customlogger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
