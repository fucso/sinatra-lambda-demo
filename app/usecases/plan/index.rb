require_relative '../../infrastructures/database'
require_relative '../../repositories/plan'

module UseCase
  module Plan
    class Index
      def execute
        database = Infrastracture::Database.new
        Repository::Plan.new(database).all
      end
    end
  end
end