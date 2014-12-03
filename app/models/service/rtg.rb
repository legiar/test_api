class Service::RTG < Service

  class BonusCode
    attr_accessor :number
  end

  def find_code(number)
    response = connection.get '/query', { code: number }
    if response.status == 200
      code = BonusCode.new
      code.number = number
      code
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def validate_code(code)
    response = connection.get '/validate', { code: code.number }
    response.status == 200
  end

  private

    def connection
      @connection ||= Faraday.new(url: 'http://localhost:3302') do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end

end
