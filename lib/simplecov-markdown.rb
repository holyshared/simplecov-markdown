require "simplecov-markdown/version"

class SimpleCov::Formatter::MarkdownFormatter
  def format(result)
    report_writer = ReportWriter.new(SimpleCov::Formatter::MarkdownFormatter.output_path)
    report_writer.write_header "Code Coverage Report"
    report_writer.write_result(result)
    report_writer.destroy!


#    @report = File.open(SimpleCov::Formatter::MarkdownFormatter.output_path, 'w')
 #   @report.puts "Code Coverage Report"
  #  @report.puts "======================\n\n"
   # @report.puts "|File|Coverage|"
  #  @report.puts "|:--|--:|"
  #  result.files.each do |file|
  #    @report.puts "|#{file.filename}|#{file.covered_percent}%|"
  #  end
  #  @report.close
  end
  def self.output_path
    File.join(SimpleCov.coverage_path, 'report.md')
  end

  class ReportWriter
    attr_reader :report

    def initialize(report_path)
      @report = File.open(report_path, 'w')
      @table_writer = TableWriter.new(report)
    end

    def write_header(title)
      @report.puts title
      @report.puts "======================\n\n"
    end

    def write_result(result)
      @table_writer.write_header
      result.files.each do |file|
        @table_writer.write_record(file.filename, file.covered_percent.to_s + "%")
      end
    end

    def destroy!
      @report.close
      @report = nil
    end

    private

    def writeln(value)
      @report.puts value + "\n"
    end
  end

  class TableWriter
    attr_reader :report, :columns_headers, :columns_header_aligns

    def initialize(report)
      @report = report
      @columns_headers = ["File", "Coverage"]
      @columns_header_aligns = [:left, :right]
    end

    def write_header
      @report.puts "|" + @columns_headers.join("|") + "|"

      headers = @columns_header_aligns.map do |align|
        case align
          when :left
            ":--"
          when :right 
            "--:"
          else
            "--" 
        end
      end
      @report.puts "|" + headers.join("|") + "|"
    end

    def write_record(*args)
      @report.puts "|" + args.join("|") + "|"
    end
  end

end
