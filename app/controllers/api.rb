require_relative '../helpers/json'

module ApiController
  def ok(data, format = {})
    {
      status: 'ok',
      data: Helper::Json.from(data, format),
    }.to_json
  end
end