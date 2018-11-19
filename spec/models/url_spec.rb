require 'rails_helper'

# TODO: Remove slug column
RSpec.describe Url, type: :model do
  describe "prepend_path_with_protocol_if_missing" do
    describe "when a url is created with a path not including the protocol" do
      it "prepends 'http://' to the front" do
        # TODO: use factorybot
        url = Url.new({path: "google.com"})
        expect(url.path).to eq('http://google.com')
      end
    end
  end

  describe "self.valid_slug?" do
    describe "when the slug only contains alphanumeric characters" do
      let(:slug) { "thisisavalidslug" }

      it "returns true" do
        expect(described_class.valid_slug?(slug)).to eq(true)
      end
    end

    describe "when the slug contains non alphanumeric characters" do
      let(:slug) { "this/isnt/a/valid/slug" }

      it "returns false" do
        expect(described_class.valid_slug?(slug)).to eq(false)
      end
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
