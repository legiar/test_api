class Api::V1::BonusCodesController < ApplicationController

  def validate
    product = Product.find(params.require(:product_id))

    bonus_code = product.find_code(params.require(:bonus_code))

    if product.validate_code(bonus_code)
      render json: { valid: true }
    else
      render json: { valid: false }, status: :forbidden
    end
  end

end
