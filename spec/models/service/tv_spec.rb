require 'rails_helper'

describe Service::TV do

  describe "#validate_code" do
    let(:valid_code) { double(:code, number: "567") }
    let(:used_code) { double(:code, number: "789") }

    before do
      stub_request(:get, "http://localhost:3301/validate?code=567").
        to_return(status: 200, body: MultiJson.dump({ valid: true }), headers: { "Content-Type" => "application/json" })

      stub_request(:get, "http://localhost:3301/validate?code=789").
        to_return(status: 403, body: MultiJson.dump({ valid: false }), headers: { "Content-Type" => "application/json" })
    end

    it "for valid code" do
      expect(subject.validate_code(valid_code)).to eql true
    end

    it "for used code" do
      expect(subject.validate_code(used_code)).to eql false
    end
  end
end
