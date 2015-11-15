require 'csv'
require_relative 'dinosaur'

class DinoCatalog::DinoImporter
	attr_reader :dinosaur_list

	def initialize
		@dinosaur_list = []
	end

	def import_from_csv(file, adapter = nil)
		adapt_csv(adapter)
		parse_csv(file)
	end

	private

	def parse_csv(file)
		CSV.parse(file) do |row|
			add_to_list(convert_to_dinosaur(row))
		end
		dinosaur_list
	end

	def convert_to_dinosaur(row_data)
		dinosaur = Dinosaur.new(
								name: row_data["NAME"],
							  period: row_data["PERIOD"],
						   continent: row_data["CONTINENT"],
								diet: row_data["DIET"],
					   weight_in_lbs: row_data["WEIGHT_IN_LBS"],
								size: row_data["SIZE"],
							 walking: row_data["WALKING"],
						 description: row_data["DESCRIPTION"],
			)
	end

	def add_to_list(dinosaur)
		dinosaur_list << dinosaur
	end
end