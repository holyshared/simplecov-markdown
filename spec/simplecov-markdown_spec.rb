require 'simplecov'
require 'erb'
require 'rspec/temp_dir'

describe 'MarkdownFormatter' do
  include_context "uses temp dir"

  let(:formatter) do
    SimpleCov::Formatter::MarkdownFormatter.stub(:output_path).and_return(report_path)
    SimpleCov::Formatter::MarkdownFormatter.new
  end
  let(:report_path) { File.join(temp_dir_path, 'report.md') }
  let(:expect_report) do
    root_directory = File.dirname(__FILE__)
    erb_script = File.open(File.join(File.dirname(__FILE__), 'fixtures/report.md.erb')).read
    ERB.new(erb_script).result(binding)
  end
  let(:result) do
    sample1 = File.join(File.dirname(__FILE__), 'fixtures', 'sample1.rb')
    sample2 = File.join(File.dirname(__FILE__), 'fixtures', 'sample2.rb')

    original_result = {
      sample1 => [nil, 1, 1, 1, nil, nil, 1, 1, nil, nil],
      sample2 => [nil, 1, 1, 1, nil, nil, 1, 0, nil, nil]
    }
    SimpleCov::Result.new(original_result)
  end

  describe '#result' do
    it 'format by markdown' do
      formatter.format(result)
      actual_report = File.open(report_path).read
      expect(actual_report).to be_eql(expect_report)
    end
  end
end
