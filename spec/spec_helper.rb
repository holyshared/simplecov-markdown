$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
require 'simplecov-console'

if ENV["COVERALLS_REPO_TOKEN"]
  require 'coveralls'
  Coveralls.wear!
else
  SimpleCov.formatters = [
    SimpleCov::Formatter::Console,
    SimpleCov::Formatter::MarkdownFormatter
  ]
end

SimpleCov.start do
  add_filter do |source_file|
    source_file.filename =~ /spec/ && !(source_file.filename =~ /fixtures/)
  end
end

require 'simplecov-markdown'
