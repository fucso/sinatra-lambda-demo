require 'active_support/core_ext/object/json'

module Helper
  class Json
    def self.from(object, format)
      return object.as_json unless format.is_a?(Hash)
    
      serialized_data = {}

      # only, exclude はそのままオブジェクトに適用
      current_layer_format = format.slice(:only, :exclude)
      if current_layer_format.length > 0
        serialized_data.merge!(object.as_json(current_layer_format))
      end

      # include は再帰的に処理
      if format.key?(:include)
        include = format[:include]
        if include.is_a?(Hash)
          include.each do |key, sub_format|
            value = object.respond_to?(key) ? object.send(key) : object[key]
            next if value.nil?

            if value.is_a?(Array)
              serialized_data[key] = value.map { |item| Json.from(item, sub_format) }
            else
              serialized_data[key] = Json.from(value, sub_format)
            end
          end
        else
          value = object.respond_to?(include) ? object.send(include) : object[include]
          serialized_data[include] = value.as_json
        end
      end
    
      serialized_data
    end
  end
end