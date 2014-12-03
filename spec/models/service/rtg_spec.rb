require 'rails_helper'

describe Service::RTG do

  describe "#find_code" do
    before do
      stub_request(:get, "http://localhost:3302/query?code=123").
        to_return(status: 200, body: MultiJson.dump({ ok: true }), headers: { "Content-Type" => "application/json" })

      stub_request(:get, "http://localhost:3302/query?code=345").
        to_return(status: 404, body: MultiJson.dump({ error: "Not found" }), headers: { "Content-Type" => "application/json" })
    end

    it "for known code return object, similar to BonusCode" do
      obj = subject.find_code("123")
      expect(obj.number).to eql "123"
    end

    it "for unknown code raise exception" do
      expect{
        subject.find_code("345")
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#validate_code" do
    let(:valid_code) { double(:code, number: "123") }
    let(:used_code) { double(:code, number: "345") }

    before do
      stub_request(:get, "http://localhost:3302/validate?code=123").
        to_return(status: 200, body: MultiJson.dump({ valid: true }), headers: { "Content-Type" => "application/json" })

      stub_request(:get, "http://localhost:3302/validate?code=345").
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
