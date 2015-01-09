require "simplecov-markdown/version"

class SimpleCov::Formatter::MarkdownFormatter
  def format(result)
    report_writer = ReportWriter.new(SimpleCov::Formatter::MarkdownFormatter.output_path)
    report_writer.write_header "Code Coverage Report"
    report_writer.write_description(result)
    report_writer.write_result(result)
    report_writer.destroy!
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
      @report.puts "=" * 20
      @report.puts "\n"
    end

    def write_description(result)
      @report.puts "Project name: " + SimpleCov.project_name
      @report.puts "Created at: " + result.created_at.to_s
      @report.puts "\n"
    end

    def write_result(result)
      @table_writer.write_header
      result.files.each do |file|
        @table_writer.write_record(
          file.filename,
          file.covered_percent.round(2).to_s + "%",
          file.covered_lines.size,
          file.missed_lines.size,
          file.lines_of_code
        )
      end
      @table_writer.destroy!
    end

    def destroy!
      @report.close
      @report = nil
    end
  end

  class TableWriter
    attr_reader :report, :columns_headers, :columns_header_aligns

    def initialize(report)
      @report = report
      @columns_headers = ["File", "Coverage", "Covered", "Missed", "Total"]
      @columns_header_aligns = [:left, :right, :right, :right, :right]
    end

    def write_header
      write_values @columns_headers
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
      write_values headers
    end

    def write_record(*args)
      write_values args
    end

    def destroy!
      @report = nil
    end

    private

    def write_values(*args)
      @report.puts "|" + args.join("|") + "|"
    end
  end
end
