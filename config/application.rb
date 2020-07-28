# frozen_string_literal: true

require_relative 'boot'

require 'rails'

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_view/railtie'
require 'action_cable/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Justonceapp
  class Application < Rails::Application
    config.load_defaults 6.0

    config.paths.add 'lib', eager_load: true
    config.paths.add 'grocery_list/lib', eager_load: true
  end
end
