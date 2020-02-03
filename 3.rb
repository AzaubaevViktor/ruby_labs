class Statistic
  attr_accessor :total_error_count
  attr_accessor :class_error_hash

  def initialize
    @total_error_count = 0
    @class_error_hash = Hash.new(0)
  end

  def process(filename)
    println "start processing #{filename}..."
    pattern = /
				(?<date>\d{4}-\d{2}-\d{2}) # date
				\s+ # separator
				(?<time>\d{2}:\d{2}:\d{2},\d{3}) # time
				\s+
				\[(?<thread>.+)\] # thread name
				\s+
				(?<logLevel>\w+) # log level
				\s+
				(?<className>\S+)- # className with dash in the end
				\s+
				(?<message>.*) # log message
				/x
    File.open(filename, "r") { |file|
      file.each_line { |line|
        # puts "processing line #{line}"
        match_result = pattern.match(line)
        if match_result != nil
          @total_error_count = total_error_count + 1
          @class_error_hash[match_result[:className]] = @class_error_hash[match_result[:className]] + 1
        else
          #	puts "not matched!"
        end
      }
    }
    puts "processing finished"
  end

  def print_class_names_and_count
    @class_error_hash.sort_by { |key, value|
      -value
    }
        .to_h
        .each { |key, value|
          puts "#{key}: #{value} errors"
        }
    puts "--------------------------------"
    puts "total count: #{@total_error_count}"
  end
end

s = Statistic.new
s.process("input.log")
s.print_class_names_and_count