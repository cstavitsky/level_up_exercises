class DinoCatalog::Dinosaur
	ATTRIBUTES = [:name, :description, :walking, :diet, :period, :weight_in_lbs, :continent, :size]
  attr_reader *ATTRIBUTES

	def initialize(
		name: nil,
		period:        nil, 
		continent:     nil,
		diet:          nil,
		weight_in_lbs: nil,
		walking:       nil,
		size:          nil, 
		description:   nil)

		@name 					= name
		@period 				= period
		@continent 			= continent
		@diet 					= diet
		@weight_in_lbs 	= weight_in_lbs
		@size 					= calculated_size(weight_in_lbs.to_i)
		@walking 				= walking
		@description 		= description
	end

	def print_facts
		puts format_facts
	end

	def format_facts
		attributes_with_values = ATTRIBUTES.select do |attribute|
			send(attribute)
		end

		attributes_with_values.map do |attribute|
			"#{attribute}: #{send(attribute)}"
		end.join("\n")
	end

	def to_json
		json_hash = {}
		self.instance_variables.each do |variable|
			json_hash[variable] = self.instance_variable_get(variable)	
		end
		json_hash
	end

	private

	def calculated_size(weight_in_lbs)
		if weight_in_lbs >= 2000
			"big"
		elsif weight_in_lbs > 0
			"small"
		else
			nil
		end
	end
end