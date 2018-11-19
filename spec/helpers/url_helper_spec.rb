require 'rails_helper'

RSpec.describe UrlHelper, type: :helper do
  describe "self.encode" do
    it "encodes the integer correctly" do
      expect(described_class.encode(1)).to eq("b")
    end
  end

  describe "self.decode" do
    it "decodes the slug correctly" do
      expect(described_class.decode("b")).to eq(1)
    end
  end
end
