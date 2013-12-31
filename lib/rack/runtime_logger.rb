class Rack::RuntimeLogger
  def initialize(app, name = nil)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    status, headers, body = @app.call(env)

    if headers.has_key?('X-Runtime') && request.path_info !~ /\.[^.]+$/
      growth_forecast = GrowthForecast.new('localhost', 5125)
      runtime = headers['X-Runtime']
      growth_forecast.post('bacu', 'response', request.path_info, runtime)
    end

    [status, headers, body]
  end
end
