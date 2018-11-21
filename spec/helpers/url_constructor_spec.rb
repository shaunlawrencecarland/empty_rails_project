require 'rails_helper'

RSpec.describe UrlConstructor, type: :helper do
  before(:each) { allow(UrlHelper).to receive(:encode) }

  describe "when a URL already exists with the same path at time of construction" do
    let!(:url) { FactoryBot.create(:url, path: "http://google.com", slug: "foo") }

    it "does not construct a new URL" do
      expect { described_class.create!("http://google.com") }.to_not change { Url.count }
    end

    it "returns a URL with a path already exists error message" do
      constructed_url = described_class.create!(url.path)
      expected_error_msg = { :path => ["URL http://google.com already exists.  Its slug is foo"] }
      expect(constructed_url.errors.messages).to eq(expected_error_msg)
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
