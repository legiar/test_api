require 'rails_helper'

describe BonusCode do

  context "factory" do
    it "be valid" do
      expect(build :bonus_code).to be_valid
    end

    it "be creatable" do
      expect(create :bonus_code).to be_persisted
    end
  end
end
