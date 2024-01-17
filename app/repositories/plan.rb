require 'sequel'
require_relative 'concern/database_connectable_concern'
require_relative 'plan/demand_charge'
require_relative 'plan/energy_charge'
require_relative '../domains/plan'

module Repository
  class Plan
    include DatabaseConnectableConcern

    RELATIONS = {
      demand_charges: DemandCharge,
      energy_charges: EnergyCharge
    }

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
      relations = RELATIONS.keys.map do |table|
        records = @database.query(table).where(plan_id: plan_ids).all
        [table, records.group_by { |r| r[:plan_id] }]
      end.to_h
      
      dataset.map do |plan|
        id = plan[:id]
        sub_models = relations.map do |table, records_by_plan|
          rows = records_by_plan[id]
          [table, rows.map { |row| RELATIONS[table].to_model(row) }]
        end.to_h
        to_model(plan, **sub_models)
      end
    end

    def to_model(record, demand_charges: [], energy_charges: [])
      Plan.new(
        id: record[:id],
        name: record[:name],
        code: record[:code],
        demand_charges: demand_charges,
        energy_charges: energy_charges
      )
    end
  end
end