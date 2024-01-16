require_relative '../plan'

class Plan::DemandCharge
  attr_accessor :id, :ampere_from, :ampere_to, :charge

  def initialize(id:, ampere_from:, ampere_to:, charge:)
    @id = id
    @ampere_from = ampere_from
    @ampere_to = ampere_to
    @charge = charge
  end
end