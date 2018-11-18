require 'rails_helper'

# TODO: Remove slug column
RSpec.describe Url, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

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

  describe "self.valid_url?" do
    context "invalid urls" do
      let(:url) { "foo" }

      it "returns false" do
        expect(described_class.valid_url?(url)).to eq(false)
      end
    end
    context "valid urls" do
      let(:url) { "google.com" }

      it "returns true" do
        expect(described_class.valid_url?(url)).to eq(true)
      end

      describe "when the url has multiple domain extensions" do
        let(:url) { "google.co.uk" }

        it "returns true" do
          expect(described_class.valid_url?(url)).to eq(true)
        end
      end

      describe "when the url includes www" do
        let(:url) { "www.google.com" }

        it "returns true" do
          expect(described_class.valid_url?(url)).to eq(true)
        end
      end

      describe "when the url includes http://" do
        let(:url) { "http://www.google.com" }

        it "returns true" do
          expect(described_class.valid_url?(url)).to eq(true)
        end
      end

      describe "when the url includes https://" do
        let(:url) { "https://www.google.com" }

        it "returns true" do
          expect(described_class.valid_url?(url)).to eq(true)
        end
      end
    end
  end
end
