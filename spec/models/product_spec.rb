require 'rails_helper'

describe Product do

  context "factory" do
    it "be valid" do
      expect(build :product).to be_valid
    end

    it "be creatable" do
      expect(create :product).to be_persisted
    end
  end

  context "without service" do
    let!(:product) { create(:product) }
    let!(:number) { "123" }
    let!(:bonus_code) { create(:bonus_code, number: number, product_id: product.id) }

    describe "#find_code" do
      it "should find code in DB" do
        expect(product.find_code(number)).to eq bonus_code
      end

      it "should raise ActiveRecord::RecordNotFound if not found" do
        expect{
          product.find_code("111")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "#validate_code" do

      it "check valid code" do
        expect(bonus_code).to receive(:used?).and_return(false)
        expect(product.validate_code(bonus_code)).to eq true
      end

      it "check used code" do
        expect(bonus_code).to receive(:used?).and_return(true)
        expect(product.validate_code(bonus_code)).to eq false
      end
    end
  end

  context "with service that doesn't provide codes" do
    let!(:service) { create(:service, status: true) }
    let!(:product) { create(:product, service_id: service.id) }
    let!(:number) { "123" }
    let!(:bonus_code) { create(:bonus_code, number: number, product_id: product.id) }

    describe "#find_code" do
      it "should find code in DB" do
        expect(product.find_code(number)).to eq bonus_code
      end

      it "should raise ActiveRecord::RecordNotFound if not found" do
        expect{
          product.find_code("111")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "#validate_code" do

      it "check valid code" do
        expect_any_instance_of(Service).to receive(:validate_code).with(bonus_code).and_return(true)
        expect(product.validate_code(bonus_code)).to eq true
      end

      it "check used code" do
        expect_any_instance_of(Service).to receive(:validate_code).with(bonus_code).and_return(false)
        expect(product.validate_code(bonus_code)).to eq false
      end
    end
  end

  context "with service that provide codes" do
    let!(:service) { create(:service, codes: true) }
    let!(:product) { create(:product, service_id: service.id) }
    let!(:number) { "123" }
    let!(:bonus_code) { double(:bonus_code) }

    describe "#find_code" do
      it "should find code in DB" do
        expect_any_instance_of(Service).to receive(:find_code).with("123").and_return(bonus_code)
        expect(product.find_code(number)).not_to be_nil
      end

      it "should raise ActiveRecord::RecordNotFound if not found" do
        expect_any_instance_of(Service).to receive(:find_code).with("111") { raise ActiveRecord::RecordNotFound }
        expect{
          product.find_code("111")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
