require 'sequel'
require_relative '../domains/plan'
require_relative 'concern/database_connectable_concern'

module Repository
  class Plan
    include DatabaseConnectableConcern

    RELATIONS = [:demand_charges, :energy_charges].freeze

    def all
      dataset_to_model(query.all)
    end

    def find_by_capacity(capacity)
      dataset = query.join(:demand_charges, plan_id: :id).select_all(:plans).where(::Sequel.lit('? BETWEEN ampere_from AND ampere_to', capacity))
      dataset_to_model(dataset.all)
    end

    private

    def query
      @database.query(:plans)
    end

    def dataset_to_model(dataset)
      plan_ids = dataset.map { |p| p[:id] }

      # { table_name: { plan_id: record[] } }
      relations = RELATIONS.map do |table|
        records = @database.query(table).where(plan_id: plan_ids).all
        [table, records.group_by { |r| r[:plan_id] }]
      end.to_h
      
      dataset.map do |plan|
        id = plan[:id]
        sub_models = relations.map do |table, records_by_plan|
          rows = records_by_plan[id]
          [table, rows]
        end.to_h
        to_model(plan.merge(sub_models))
      end
    end

    def to_model(record)
      ::Plan.new(**record)
    end
  end
end