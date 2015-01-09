$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'

if ENV["COVERALLS_REPO_TOKEN"]
  require 'coveralls'
  Coveralls.wear!
end

SimpleCov.start do
  add_filter do |source_file|
    source_file.filename =~ /spec/ && !(source_file.filename =~ /fixtures/)
  end
end

require 'simplecov-markdown'
