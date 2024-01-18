require 'pg'
require 'sequel'

module Infrastracture
  class Database

    def initialize
      host = ENV['DB_HOST']
      user = ENV['DB_USER']
      password = ENV['DB_PASSWORD']
      database = ENV['DB_NAME']
      @db = Sequel.connect("postgres://#{user}:#{password}@#{host}/#{database}")
    end

    def query(table)
      @db[table]
    end
  end
end