require_relative '../../infrastructures/database'
require_relative '../../repositories/plan'

module UseCase
  module Plan
    class Index
      def execute
        database = Infrastracture::Database.new
        plans = Repository::Plan.new(database).all
        
        plan = plans[0]
        puts plan.demand_charges[0].charge

        plans
      end
    end
  end
end