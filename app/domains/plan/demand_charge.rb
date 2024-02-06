require_relative '../domain'

class Plan
  class DemandCharge
    include Domain
    attr_accessor :id, :ampere_from, :ampere_to, :charge
  end
end