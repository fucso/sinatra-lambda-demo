require_relative '../../domains/plan/energy_charge.rb'

module Repository
  class Plan < Repository::Base
    class EnergyCharge
      class << self
        def to_model(record)
          ::Plan::EnergyCharge.new(**(record.reject { |k, v| k == :plan_id }))
        end
      end
    end
  end
end