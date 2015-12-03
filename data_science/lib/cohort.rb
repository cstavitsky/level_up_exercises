require_relative 'visit'
require 'abanalyzer'
require 'pry'

class Cohort
  attr_reader :visits
  private :visits

  def initialize(visits)
    validate_visits(visits)
    @visits = visits
    @conversions ||= conversions
  end

  def sample_size
    visits.length
  end

  def num_conversions
    conversions.length
  end

  def conversion_rate(confidence = 0.95)
    ABAnalyzer.confidence_interval(num_conversions, sample_size, confidence)
  end

  def <=>(cohort_to_compare)
    conversion_rate <=> cohort_to_compare.conversion_rate
   end

  private

  def validate_visits(visits)
    visit_cohort = visits.first.cohort
    if visits.find { |visit| visit.cohort != visit_cohort }
      raise "All visits must be from the same cohort"
    end
  end

  def conversions
    converted = 1
    @conversions = visits.select { |visit| visit.result == converted }
  end
end
