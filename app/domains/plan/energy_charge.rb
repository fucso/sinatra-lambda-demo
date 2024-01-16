class Plan::EnergyCharge
  attr_accessor :id, :kwh_from, :kwh_to, :rate
  
  def initialize(id:, kwh_from:, kwh_to:, rate:)
    @id = id
    @kwh_from = kwh_from
    @kwh_to = kwh_to
    @rate = rate
  end
end