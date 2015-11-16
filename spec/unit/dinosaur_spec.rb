require_relative '../../lib/dino_catalog'

describe DinoCatalog::Dinosaur do

	before :each do
		@dinosaur = DinoCatalog::Dinosaur.new(name: "trex", walking: "biped")
  end
  
	describe '#print_facts' do
		it 'omits attribute headers without values' do
			expect(@dinosaur.print_facts).to eq("name: trex\nwalking: biped")
		end
	end
end