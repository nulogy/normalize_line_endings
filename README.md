# NormalizeLineEndings

Converts \r\n characters to \n for attributes on ActiveModel-like entities.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'normalize_line_endings'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install normalize_line_endings

## Usage

Run tests by cd'ing to the root of the gem directory and running `rake test`

```
class Post < ApplicationRecord
  normalize_line_endings :only => [:foo, :bar, :biz]
end
```

See the tests for more example usages.
