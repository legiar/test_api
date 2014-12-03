class Product < ActiveRecord::Base
  belongs_to  :service

  has_many :bonus_codes, inverse_of: :product

  def service
    super || Service.new
  end

  def find_code(number)
    service.codes? ? service.find_code(number) : bonus_codes.find_by_number!(number)
  end

  def validate_code(code)
    service.status? ? service.validate_code(code) : !code.used?
  end

end
