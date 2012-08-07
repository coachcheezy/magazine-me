class Rack::Throttle::Limiter
  def http_error(code, message = nil, headers = {})
    [code, {'Content-Type' => 'text/plain; charset=utf-8'}.merge(headers),
    [http_status(code) + (message.nil? ? "\n" : " (#{message})\n")]]
  end
end