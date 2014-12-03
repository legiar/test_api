require 'rails_helper'

describe Service do

  let(:service) { create(:service) }

  context "factory" do
    it "be valid" do
      expect(build :service).to be_valid
    end

    it "be creatable" do
      expect(create :service).to be_persisted
    end
  end

  it "raise error for default service" do
    expect{
      service.find_code("123")
    }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "return false when validate in default service" do
    code = double
    expect(service.validate_code(code)).to eq false
  end
end
