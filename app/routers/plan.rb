require_relative 'base'
require_relative '../usecases/plan/index'
   
module Router
  class Plan < Router::Base
    get '/plans' do
      usecase = UseCase::Plan::Index.new
      ok(usecase.execute)
    end
  end
end