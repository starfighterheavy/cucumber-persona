# Cucumber::Persona

[![Code Climate](https://codeclimate.com/github/starfighterheavy/edward/badges/gpa.svg)](https://codeclimate.com/github/starfighterheavy/edward)

One of the hardest things to do in Cucumber is define the state of the world, from a data perspective, that a test should be run in. Gems like [cucumber_factory](https://github.com/makandra/cucumber_factory) try to make this easier, and they are often enough. But even simple tests can require extensive background data to be run well. Cucumber::Persona attempts to solve this by completely removing data setup from your cucumber feature scripts.

To use Cucumber::Persona, take the persona's you have already created for various user types (you've done that, right? ;), and create a Cucumber::Persona for each. Then, in your feature test setup, instantiate the Cucumber::Persona you need by adding a `Given` statement in the form:

```
Given I am "Han Solo"
...
```

Going forward, your tests will be geared at testing functionality from the perspective of a known user Persona. This will result in slower tests, as you will end up creating more test data per test than you had before. But the amount of time you will save yourself in specifying data conditions for each test could, depending on your application, be well worth it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cucumber-persona'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cucumber-persona

## Usage

In your `feaqtures/support/env.rb` file, add `require 'cucumber/persona'`.

In your `features/support` directory, create a `personas.rb' file. Then define a persona, similar to how you would define a model with FactoryGirl.

```
Cucumber::Persona.define "Han Solo" do
  # Create the user
  user = User.create!(first_name: "Han", last_name: "Solo", email: "han@solo.com", password: "Password1")
  # Create any additional data needed to flesh out the user's state of the world at the time of the test.
  # Example below is for a todo list application where our user Han has 3 tasks and completed 1.
  user.tasks.create!(title: "First task", completed: Time.now)
  user.tasks.create!(title: "Second task")
  user.tasks.create!(title: "Third task")
end
```

Create a new step definition to instantiate your new persona.

```
Given /^I am "(.*)"$/ do |name|
  Cucumber::Persona.find(name).create
end
```

To use your Personas elsewhere, like in your `db/seed` file, add the following:

```
require 'cucumber/persona'
require_relative '../features/support/personas'

Cucumber::Persona.create_all
```

Note: If you have many personas, you can split them up into different files, just remember to require them when used outside of cucumber.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/starfighterheavy/cucumber-persona. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

