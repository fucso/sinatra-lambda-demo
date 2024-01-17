require_relative '../../domains/plan/demand_charge'

module Repository
  class Plan < Repository::Base
    class DemandCharge
      class << self
        def to_model(record)
          ::Plan::DemandCharge.new(**(record.reject { |k, v| k == :plan_id }))
        end
      end
    end
  end
end