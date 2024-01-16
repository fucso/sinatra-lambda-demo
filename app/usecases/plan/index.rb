require_relative '../../repositories/database'
require_relative '../../repositories/plan'

module UseCase
  module Plan
    class Index
      def execute
        database = Repository::Database.new
        Repository::Plan.all(database)
      end
    end
  end
end