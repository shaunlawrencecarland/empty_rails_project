require 'rails_helper'

RSpec.describe UrlConstructor, type: :helper do
  before(:each) { allow(UrlHelper).to receive(:encode) }

    describe "when a url is created with a path not including the protocol" do
      it "prepends 'http://' to the front of the constructed url's path" do
        url = described_class.create!("foo.com")
        expect(url.path).to eq('http://foo.com')
      end
    end


  describe "when a URL already exists with the same path at time of construction" do
    let!(:url) { FactoryBot.create(:url, path: "http://google.com", slug: "foo") }

    it "does not construct a new URL" do
      expect { described_class.create!("http://google.com") }.to_not change { Url.count }
    end

    it "returns the existing URL" do
      expect(described_class.create!("http://google.com")).to eq(url)
    end
  end

  describe "when there is a failure saving the url" do
    before(:each) { allow_any_instance_of(Url).to receive(:save!).and_return(false) }

    it "does not construct a new URL" do
      expect { described_class.create!("http://foo.com") }.to_not change { Url.count }
    end

    it "returns a URL with the unknown error message" do
      constructed_url = described_class.create!("http://foo.com")
      expected_error_msg = { :base => ["Error: URL could not be saved for an unknown reason"] }
      expect(constructed_url.errors.messages).to eq(expected_error_msg)
    end
  end

  describe "when there are no failures" do
    it "creates a new URL" do
      expect { described_class.create!("http://foo.com") }
        .to change { Url.count }.from(0).to(1)
    end
  end
end
