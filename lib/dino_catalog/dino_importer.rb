require 'csv'
require_relative '../dino_catalog'

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

	def adapt_csv(adapter)
		if adapter
			p "Adapting CSV to proper format..."
			#do something
		end
	end

	def parse_csv(file)
		CSV.foreach(file, headers: true) do |row|
			p dinosaur = convert_to_dinosaur(row)
			add_to_list(dinosaur)
		end
		dinosaur_list
	end

	def convert_to_dinosaur(row_data)
		p row_data
		dinosaur = DinoCatalog::Dinosaur.new(
								name: row_data["NAME"],
							  period: row_data["PERIOD"],
						   continent: row_data["CONTINENT"],
								diet: row_data["DIET"],
					   weight_in_lbs: row_data["WEIGHT_IN_LBS"].to_i,
								size: row_data["SIZE"],
							 walking: row_data["WALKING"],
						 description: row_data["DESCRIPTION"],
			)
	end

	def add_to_list(dinosaur)
		dinosaur_list << dinosaur
	end
end

a = DinoCatalog::DinoImporter.new
a.import_from_csv('../dinodex.csv')