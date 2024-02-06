require 'sinatra'
require_relative 'routers/plan'

before do
  if (! request.body.read.empty? and request.body.size > 0)
    request.body.rewind
    @params = Sinatra::IndifferentHash.new
    @params.merge!(JSON.parse(request.body.read))
  end
end

use Router::Plan