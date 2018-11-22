require 'rails_helper'

RSpec.describe Url, type: :model do
  describe "path_validation" do
    context "invalid urls" do
      let(:url) { FactoryBot.create(:url, path: "foo") }

      it "raises an ActiveRecord::RecordInvalid exception" do
        expect { url.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "valid urls" do
      describe "when the url has multiple domain extensions" do
        let(:url) { FactoryBot.create(:url, path: "foo.co.uk") }

        it "does not raise an exception" do
          expect{url.save!}.to_not raise_error
        end
      end

      describe "when the url includes www" do
        let(:url) { FactoryBot.create(:url, path: "www.foo.com") }

        it "does not raise an ActiveRecord::RecordInvalid error" do
          expect{url.save!}.to_not raise_error
        end
      end

      describe "when the url includes http://" do
        let(:url) { FactoryBot.create(:url, path: "http://foo.com") }

        it "does not raise an exception" do
          expect{url.save!}.to_not raise_error
        end
      end

      describe "when the url includes https://" do
        let(:url) { FactoryBot.create(:url, path: "https://foo.com") }

        it "does not raise an exception" do
          expect{url.save!}.to_not raise_error
        end
      end
    end
  end
end
