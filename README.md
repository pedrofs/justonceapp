# JustOnce - The ultimate grocery list

You'll never need to get back to the grocery for buying that cleansing product or your kid milk because you forgot it.

## About the app

This is a rails application written to improve CQRS and Event Sourcing skills.

It is powered by [Rails Event Store](https://railseventstore.org/) to implement the Event Sourcing.

Besides a regular rails application, you'll find `app/read_models` that implements the read part of CQRS and you'll also find the `grocery_list/`, used to implemented the write side of CQRS.

## Setup

Standard rails setup with postgres.

```sh
$ git clone git@github.com:pedrofs/justonceapp.git
$ cd justonceapp
$ yarn install
$ bundler
$ rake db:setup
$ foreman start
```

## Running specs

We also have specs outside of `spec/` folders. For running all specs use `--pattern`.

```sh
$ SIMPLE_COV=true bundle exec rspec  --pattern spec/**/*_spec.rb --pattern grocery_list/**/*_spec.rb
```

The simple cov option generates html coverage report, without it'll generate the report using lcov format.
