require_relative '../../infrastructures/database'

module Repository
  module DatabaseConnectableConcern
    def initialize(database)
      @database = database
    end
  end
end