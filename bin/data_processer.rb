=begin
This class is the root class which initializes the data parsing process.
=end

#!/usr/bin/env ruby 

$LOAD_PATH.unshift File.expand_path('../../lib',__FILE__)
require 'optparse' 
require 'ostruct'
require 'data_handler'
require 'states'

class DataParser
  VERSION = '0.0.1'

  def initialize(arguments, stdin)
    @arguments = arguments
    @stdin = stdin

    @options = OpenStruct.new
    @options.quiet = false
    @data_handler = DataHandler.new
  end

  def run
    if parsed_options? && @arguments.length >= 1
      process_arguments
    else
      puts @option_parser
    end
  end

  private
    def process_arguments
      @data_handler.parse_file(@options.quiet, *@arguments)
    end

    def parsed_options?
      @option_parser = OptionParser.new
      @option_parser.banner = "Usage: data_parser.rb [options] data_file [output_file]"
      @option_parser.separator "       Default [output_file] is data/result.csv"
      @option_parser.separator ""
      @option_parser.separator "Specific options:"

      @option_parser.on('-v', '--version', "Show version")  { output_version ; exit 0 }
      @option_parser.on('-h', '--help', "Show helps") { puts @op; exit 0 }
      @option_parser.on('-q', '--quiet', "Without warning and error messages")    { @options.quiet = true }

      @option_parser.parse!(@arguments) rescue return false
      true
    end

    def output_version
      puts "#{File.basename(__FILE__)} version #{VERSION}"
    end
end

data_parser = DataParser.new(ARGV, STDIN)
data_parser.run