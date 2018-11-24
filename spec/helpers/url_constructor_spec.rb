require 'rails_helper'

RSpec.describe UrlConstructor, type: :helper do
  describe "#create!" do
    let(:subject) { described_class.create!(path) }
    let(:path) { "http://foo.com" }
    before(:each) { allow(UrlHelper).to receive(:encode) }

      describe "when a url is created with a path not including the protocol" do
        let(:path) { "foo.com" }

        it "prepends 'http://' to the front of the constructed url's path" do
          expect(subject.path).to eq('http://foo.com')
        end
      end

    describe "when a URL already exists with the same path at time of construction" do
      let!(:url) { FactoryBot.create(:url, path: "http://foo.com", slug: "bar") }

      it "does not construct a new URL" do
        expect { subject }.to_not change { Url.count }
      end

      it "returns the existing URL" do
        expect(subject).to eq(url)
      end
    end

    describe "when there is a failure saving the url" do
      before(:each) { allow_any_instance_of(Url).to receive(:save!).and_return(false) }

      it "does not construct a new URL" do
        expect { subject }.to_not change { Url.count }
      end

      it "returns a URL with the unknown error message" do
        error_messages = subject.errors.messages
        expected_error_msg = { :path => ["Error: URL could not be saved for an unknown reason"] }
        expect(error_messages).to eq(expected_error_msg)
      end
    end

    describe "when there are no failures" do
      it "creates a new URL" do
        expect { subject }.to change { Url.count }.from(0).to(1)
      end

      it  "makes a call to the encoder to set the slug" do
        subject
        expect(UrlHelper).to have_received(:encode).with(1)
      end
    end
  end
end
