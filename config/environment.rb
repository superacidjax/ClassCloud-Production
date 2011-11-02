# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tes::Application.initialize!

# added by Brian 
ENV['RAILS_ENV'] ||= 'production'
