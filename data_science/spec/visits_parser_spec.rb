require_relative '../lib/visits_parser'

describe VisitsParser do
	let(:data){ [{"date":"2014-03-20","cohort":"B","result":0},
								 {"date":"2014-03-20","cohort":"B","result":0},
								 {"date":"2014-03-20","cohort":"B","result":0}] 
						}
	describe ".parse" do
		it 'creates the correct number of Visits from JSON data' do
			expect(VisitsParser.parse(data).length).to eq(3)
		end

		# it 'creates objects that respond to cohort' do
		# 	object = VisitsParser.parse(data).first
		# 	expect(object.cohort).to be_truthy
		# end

		it 'returns a collection of visits'
	end
end