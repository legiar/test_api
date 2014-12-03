class Service < ActiveRecord::Base

  def find_code(number)
    raise ActiveRecord::RecordNotFound
  end

  def validate_code(bonus_code)
    false
  end
end
