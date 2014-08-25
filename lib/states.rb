=begin
 The class to process he states CSV file and to validate the state and get the state name by ID 
=end

require 'smarter_csv'

class States
  def initialize
    @states = {}
    states_file = File.expand_path('../../data',__FILE__) + "/states.csv"
    SmarterCSV.process(states_file, 
      { headers_in_file: false, user_provided_headers: ["id", "name"] }) do |row| 
      @states[row[0][:id]] = row[0][:name] 
    end
  end
		
  def valid?(id)
		@states.key?(id)
	end

  def get_name(id)
    @states[id]
  end
end