class Service::TV < Service

  def validate_code(code)
    response = connection.get '/validate', { code: code.number }
    response.status == 200
  end

  private

    def connection
      @connection ||= Faraday.new(url: 'http://localhost:3301') do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end

end
