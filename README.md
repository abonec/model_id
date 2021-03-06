[![Build Status](https://travis-ci.org/abonec/model_id.svg?branch=master)](https://travis-ci.org/abonec/model_id)

# ModelId

Gem add feature for id and find by this id across all instances of the model.

## Installation

Add this line to your application's Gemfile:

    gem 'model_id'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install model_id

## Usage

Include ModelId::Base to model's class:

    class User
        include ModelId::Base
    end

Now your model has #model_id:

    User.new.model_id

And you can find instances by id:

    user = User.new
    User.find_by_id(user.model_id) # => user

After you don't need this instance anymore you can delete it from the index by #delete_model:

    user = User.new
    User.find_by_id(user.model_id) # => user
    user.delete_model
    User.find_by_id(user.model_id) # => nil

## Notes

Since ruby < 2.0 don't have prepend method you should manually call #set_next_model_id in your constructor:

    class User
        include ModelId::Base
        def initialize
            set_next_model_id
        end
    end

## Contributing

1. Fork it ( https://github.com/abonec/model_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
