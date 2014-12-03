require "rails_helper"

describe "BonusCodes routing" do

  it { expect(get "/api/v1/bonus_codes/validate").to route_to("api/v1/bonus_codes#validate") }
end
