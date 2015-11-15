class DinoCatalog::Dinodex
	attr_reader :dinosaurs

	def initialize(dinosaurs)
		@dinosaurs = dinosaurs
	end

	def filter_by_attribute(attribute, value)
		dinosaurs.select{ |dinosaur| dinosaur.attribute.downcase == value.downcase }
	end
end