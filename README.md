# rbrc #

App config helpers for ruby apps.

## Install ##

Install with gem

    gem install rbrc

Or add to your Gemfile

    gem 'rbrc'

Or get it from `master`

    git clone 'https://github.com/mikebannister/rbrc
    cd rbrc
    gem install ./rbrc.gemspec

## Usage ##

Register a config file somewhere in your app

    require 'rbrc'

    Rbrc::Config.register(:my_app)

Now you can access the config file values like this

    Rbrc::Config.my_app.password #=> 'secret_password'
