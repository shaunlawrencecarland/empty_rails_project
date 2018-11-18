require 'rails_helper'
RSpec.describe Url, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

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
