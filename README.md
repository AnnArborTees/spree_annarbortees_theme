SpreeAnnarborteesTheme
======================

Introduction goes here.

Installation
------------

Add spree_annarbortees_theme to your Gemfile:

```ruby
gem 'spree_annarbortees_theme'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_annarbortees_theme:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_annarbortees_theme/factories'
```

Additional Credits
-------

Bootstrap code based off of
https://github.com/200Creative/spree_bootstrap_frontend/tree/2-2-stable

Copyright (c) 2014 [name of extension creator], released under the New BSD License
