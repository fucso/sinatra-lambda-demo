require_relative '../infrastructures/database'

module Repository
  class Base
    def initialize(database)
      @database = database
    end
  end
end