require_relative '../domain'

class Plan
  class EnergyCharge
    include Domain
    attr_accessor :id, :kwh_from, :kwh_to, :rate
  end
end