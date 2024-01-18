require_relative 'domain'
require_relative 'plan/demand_charge'
require_relative 'plan/energy_charge'

class Plan
  include Domain
  attr_accessor :id, :name, :code,
                :demand_charges, :energy_charges
  
  initialize_converter demand_charges: ->(records) { records.map { |r| DemandCharge.new(**r) } },
                       energy_charges: ->(records) { records.map { |r| Plan::EnergyCharge.new(**r) } }
end