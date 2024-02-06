require_relative 'api'
require_relative '../usecases/plan/index'

module Controller
  class Plan
    include ApiController
    
    def index
      usecase = UseCase::Plan::Index.new
      plans = usecase.execute
      ok(
        { plans: plans},
        {
          include: {
            plans: {
              only: ['code', 'name'],
              include: {
                demand_charges: {
                  only: ['ampere_from', 'ampere_to', 'charge']
                },
                energy_charges: {
                  only: ['kwh_from', 'kwh_to', 'rate']
                }
              }
            }
          }
        }
      )
    end
  end
end