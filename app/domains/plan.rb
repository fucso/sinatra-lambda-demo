class Plan
  attr_accessor :id, :name, :code,
                :demand_charges, :energy_charges

  def initialize(id:, name:, code:, demand_charges: [], energy_charges: [])
    @id = id
    @name = name
    @code = code
    @demand_charges = demand_charges
    @energy_charges = energy_charges
  end
end