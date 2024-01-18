require_relative 'base'
require_relative '../helpers/json'
require_relative '../usecases/plan/index'
   
module Router
  class Plan < Router::Base
    get '/plans' do
      response_format = {
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
      usecase = UseCase::Plan::Index.new
      plans = usecase.execute
      ok(
        Helper::Json.from(
          {
            plans: plans
          }, 
          response_format
        )
      )
    end
  end
end