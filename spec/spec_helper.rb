$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'

if ENV["COVERALLS_REPO_TOKEN"]
  require 'coveralls'
  Coveralls.wear!
end

require 'simplecov-markdown'
