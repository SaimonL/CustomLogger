# Custom Logger 0.0.2

Custom logger allows you to log you're debug infmration to an html file so you can
view them in much more easier way. This is my first gem so expect things not
to be perfect.

## Compatable

CustomLogger is compatable with Ruby 1.9 and above. As for Rails 3.x and up.
You should not be using or have Ruby 1.8 installed for obvious reasons.

## Installation

Add this line to your application's Gemfile:

```ruby
group :development, :test do
  [...]
  gem 'customlogger'
  [...]
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install customlogger

## Usage

Custom Logger is very easy to use. Just use the module 'CustomLogger' anywhere
and log the message in a nice view friendly coloful html page. Take a look
at the examples below.

![Example Screenshot](https://raw.githubusercontent.com/SaimonL/repo-assets/master/customlogger/all.png)

#### Log error

    CustomLogger.error 'This is an error message'
    CustomLogger.error = 'This is an error message'
    CustomLogger.error 'This is an error message', 'Error Title'

![Error Screenshot](https://raw.githubusercontent.com/SaimonL/repo-assets/master/customlogger/error.png)

#### Log warning

    CustomLogger.warning 'This is an warning message'
    CustomLogger.warning = 'This is an warning message'
    CustomLogger.warning 'This is an warning message', 'Warning Title'

![Warning Screenshot](https://raw.githubusercontent.com/SaimonL/repo-assets/master/customlogger/warning.png)

#### Log debug

    CustomLogger.debug 'This is an debug message'
    CustomLogger.debug = 'This is an debug message'
    CustomLogger.debug 'This is an debug message', 'Debug Title'

![Debug Screenshot](https://raw.githubusercontent.com/SaimonL/repo-assets/master/customlogger/debug.png)

#### Log info

    CustomLogger.info 'This is an info message'
    CustomLogger.info = 'This is an info message'
    CustomLogger.info 'This is an info message', 'Info Title'

![Info Screenshot](https://raw.githubusercontent.com/SaimonL/repo-assets/master/customlogger/info.png)

#### Log raw

Keep in mind that raw means that no formatting is applied so if the output
is 1000 characters horizontal without any line break then that is what you
will see. Basically it is inside of a 'pre' html tag.

    CustomLogger.raw 'This is an raw message'
    CustomLogger.raw = 'This is an raw message'
    CustomLogger.raw 'This is an raw message', 'Raw Title'

![Raw Screenshot](https://raw.githubusercontent.com/SaimonL/repo-assets/master/customlogger/raw.png)

#### Clear All Logs

    customlogger.clear


## Log File

You will find the log file in:

    log/customlogger.html


## Running Test On Gem (Not Rails App)

    bundle exec rake spec

## Contributing

1. Fork it ( https://github.com/SaimonL/CustomLogger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
