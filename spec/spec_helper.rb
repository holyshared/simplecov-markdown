$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
require 'simplecov-markdown'

if ENV["COVERALLS_REPO_TOKEN"]
  require 'coveralls'
  Coveralls.wear!
end
