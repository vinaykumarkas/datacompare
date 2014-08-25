=begin
This class handles the validation to the data to be processed and writes the results to the file 
and also print the details to the file
=end

require 'smarter_csv'
require 'csv'

class DataHandler
  NAME_WARNING = "Names cannot be less than four characters"
  STATE_WARNING = "The code denoting state must be in the file states.csv"
  SALARY_WARNING = "The salary must be an integer, and not a float"
  POSTCODE_ERROR = "The postcode must exist"

  attr_reader :warnings, :errors
  def initialize
    @warnings = []
    @errors = []
    @states = States.new
  end

  def parse_file(quite, filename, output=File.expand_path('../../data',__FILE__) + "/result.csv")
    CSV.open(output, "wb") do |csv|
      SmarterCSV.process(filename) do |user|
        begin
          message = validate(user[0])
          if message
            warning = { user: user[0], warning: message }
            @warnings << warning
            puts "WARNING_DATA: #{warning}" unless quite
          end

          user[0][:state] = @states.get_name(user[0][:state]).to_s
          puts "User: #{user[0]}"

          csv << user[0].values

        rescue Exception => msg
          error = { user: user[0], error: msg.to_s }
          @errors << error
          puts "ERROR_DATA: #{error}" unless quite
        end
      end
    end

    puts "\nWrite into #{output} successfully!"
  end

  def validate(user)
    raise POSTCODE_ERROR unless user[:postcode]

    return NAME_WARNING unless check_name(user[:name])
    return STATE_WARNING unless check_state(user[:state])
    return SALARY_WARNING if check_salary(user[:salary])
  end

  private

  def check_name(name)
    name.length < 4 ? false : true
  end

  def check_state(state)
    @states.valid?(state)
  end

  def check_salary(salary)
    salary.is_a? Float
  end
end