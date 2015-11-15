class Dinocatalog::Dinosaur
	def initialize(name:, period:, continent:, 
				   diet:, weight_in_lbs:,
				   size: nil, walking:, description:)
		@name 			= name
		@period 		= period
		@continent 		= continent
		@diet 			= diet
		@weight_in_lbs 	= weight_in_lbs
		@size 			= calculated_size(weight_in_lbs)
		@walking 		= walking
		@description 	= description
	end

	def print_facts
	end

	private

	def calculated_size(weight_in_lbs)
		if weight_in_lbs >= 2000
			"big"
		else
			"small"
		end
	end
end