# Cucumber::Persona

[![Code Climate](https://codeclimate.com/github/starfighterheavy/persona/badges/gpa.svg)](https://codeclimate.com/github/starfighterheavy/cucumber-persona)
[![Dependency Status](https://gemnasium.com/starfighterheavy/cucumber-persona.svg)](https://gemnasium.com/starfighterheavy/cucumber-persona)
[![Gem Version](https://badge.fury.io/rb/cucumber-persona.svg)](https://badge.fury.io/rb/cucumber-persona)

One of the hardest things to do in Cucumber is define the state of the world, from a data perspective, that a test should be run in. Gems like [cucumber_factory](https://github.com/makandra/cucumber_factory) try to make this easier, but can introduce more complexity rather than less, as even simple tests can require extensive background data to be run well. Cucumber::Persona attempts to solve this by completely removing data setup from your cucumber feature scripts and allowing total flexibility in how you create your data.

To use Cucumber::Persona, take the persona's you have already created for various user types (you've done that, right? ;), and create a Cucumber::Persona for each. Then, in your feature test setup, instantiate the Cucumber::Persona you need by adding a `Given` statement in the form:

```
Given I am "Han Solo"
...
```

or

```
Given "Han Solo" exists
...
```

And wala! All the data you need is ready to go.

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

To create your first Persona, create add a `personas` directory to your `features` directory (or wherever you'd like to place it) and create a `.rb` new file, typically named after a Persona, e.g. `han_solo.rb`, or a category of personas, e.g. `customers.rb`, similar to how you would define a model with FactoryGirl. That file will look something like this:

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

To use your persona in your tests, you can create your own persona related step definition, or use the default ones provided by including the requiring in your `env.rb` file:

```
require 'cucumber/persona/step_definitions/persona_steps`
```

You can create your own definition like the following:

```
Given /^my "(.*)" workflow exists$/ do |name|
  Cucumber::Persona.find(name).create
end
```

To use your Personas elsewhere, like in your `db/seed` file, add the following:

```
require 'cucumber/persona'
require_relative '../features/personas'

Cucumber::Persona.create_all
```

## Examples

### Edward

This project was originally extracted from [Edward](https://github.com/starfighterheavy/edward), which outgrew what [factory_bot](https://github.com/thoughtbot/factory_bot_rails) could provide cleanly.

See: https://github.com/starfighterheavy/edward/tree/master/features/personas

### BridgeCare Finance

[BridgeCare Finance](https://www.bridgecarefinance.com) uses Cucumber::Persona to create tests centered around common user personas that have their own quirks and history, rather than nameless data objects.

#### Are you using Cucumber::Persona?

Open a pull request against this README to add yourself to this list!

## Contributing

Cucumber::Personas is an intentionally simple library, and should not often need updates or new features. But if you'd like to contribute, an area that could definitely use some help is in building out tests, preferably in Cucumber.

Bug reports and pull requests are welcome on GitHub at https://github.com/starfighterheavy/cucumber-persona. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

