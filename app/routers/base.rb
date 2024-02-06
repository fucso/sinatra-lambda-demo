require 'sinatra/base'

module Router
  class Base < Sinatra::Base
    before do
      if (! request.body.read.empty? and request.body.size > 0)
        request.body.rewind
        @params = Sinatra::IndifferentHash.new
        @params.merge!(JSON.parse(request.body.read))
      end
      content_type :json
    end

    helpers do
      def ok(data)
        {
          status: 'ok',
          data: data,
        }.to_json
      end
    end
  end
end
