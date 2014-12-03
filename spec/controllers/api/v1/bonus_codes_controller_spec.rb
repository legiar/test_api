require 'rails_helper'

describe Api::V1::BonusCodesController do

  let(:product) { create(:product) }

  describe "GET #validate" do

    context "without required product_id" do
      before { get :validate }

      it "respond with 400" do
        expect(response).to have_http_status :bad_request
      end

      it "render json error" do
        expect(response.body).to be_json_eql({ error: "missing param 'product_id" }.to_json)
      end
    end

    context "without required bonus_code" do
      before { get :validate, product_id: product.id }

      it "respond with 400" do
        expect(response).to have_http_status :bad_request
      end

      it "render json error" do
        expect(response.body).to be_json_eql({ error: "missing param 'bonus_code" }.to_json)
      end
    end

    context "with invalid product_id" do
      before { get :validate, product_id: -1 }

      it "respond with 404" do
        expect(response).to have_http_status :not_found
      end

      it "render json error" do
        expect(response.body).to be_json_eql({ error: "Couldn't find Product with 'id'=-1" }.to_json)
      end
    end

    context "with valid code" do
      let!(:valid_code) { create(:bonus_code, number: "123", product_id: product.id) }
      before { get :validate, product_id: product.id, bonus_code: "123" }

      it "respond with 200" do
        expect(response).to have_http_status :ok
      end

      it "render json" do
        expect(response.body).to be_json_eql({ valid: true }.to_json)
      end
    end

    context "with used code" do
      let!(:used_code) { create(:bonus_code, number: "345", product_id: product.id, used: true) }
      before { get :validate, product_id: product.id, bonus_code: "345" }

      it "respond with 403" do
        expect(response).to have_http_status :forbidden
      end

      it "render json" do
        expect(response.body).to be_json_eql({ valid: false }.to_json)
      end
    end

    context "with unknown code" do
      before { get :validate, product_id: product.id, bonus_code: "999" }

      it "respond with 404" do
        expect(response).to have_http_status :not_found
      end
    end
  end
end
