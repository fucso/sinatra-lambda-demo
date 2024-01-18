require_relative 'base'
require_relative '../controllers/plan'
   
module Router
  class Plan < Router::Base
    get '/plans' do
      Controller::Plan.new.index
    end
  end
end