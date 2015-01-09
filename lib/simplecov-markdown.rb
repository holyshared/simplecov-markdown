require "simplecov-markdown/version"

class SimpleCov::Formatter::MarkdownFormatter
  def format(result)
    @report = File.open(SimpleCov::Formatter::MarkdownFormatter.output_path, 'w')
    @report.puts "Code Coverage Report"
    @report.puts "======================\n\n"
    @report.puts "|File|Coverage|"
    @report.puts "|:--|--:|"
    result.files.each do |file|
      @report.puts "|#{file.filename}|#{file.covered_percent}%|"
    end
    @report.close
  end
  def self.output_path
    File.join(SimpleCov.coverage_path, 'report.md')
  end
end
