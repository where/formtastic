# encoding: utf-8
require "rubygems"
require "bundler/setup"
require "rspec"

require "active_model"
require "active_support"
require "action_view"
require "action_controller"

require File.expand_path(File.join(File.dirname(__FILE__), "../lib/formtastic/util"))
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/formtastic"))

require "ammeter/init"

require "rspec_tag_matchers"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories in alphabetic order.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each {|f| require f}

::ActiveSupport::Deprecation.silenced = false

RSpec.configure do |config|
  config.mock_with :rspec

  config.include RspecTagMatchers
  config.include CustomMatchers
  config.include CustomMacros
  config.include HelperMethods
  
  config.before(:all) do
    DeferredGarbageCollection.start unless ENV["DEFER_GC"] == "false"
  end
  config.after(:all) do
    DeferredGarbageCollection.reconsider unless ENV["DEFER_GC"] == "false"
  end
end

require "action_controller/railtie"

# Create a simple rails application for use in testing the viewhelper
module FormtasticTest
  class Application < Rails::Application
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    config.active_support.deprecation = :stderr
  end
end
FormtasticTest::Application.initialize!

require "rspec/rails"

# Quick hack to avoid the 'Spec' deprecation warnings from rspec_tag_matchers
module Spec
  include RSpec
end

module FormtasticSpecHelper
  include Mocks
end