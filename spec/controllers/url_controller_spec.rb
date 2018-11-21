require 'rails_helper'
RSpec.describe Api::V1::UrlsController, type: :controller do

  describe "#create" do
    let(:subject) { post :create, params: params }
    describe "when the URL is in valid format" do
      let(:params) { { url: { path: "google.com" } } }

      it "returns a 200 response" do
        subject
        expect(response.status).to eq(200)
      end

      describe "and the URL already exists" do
        let!(:url) { FactoryBot.create(:url, path: "google.com") }
        it "returns a 422 response" do
          subject
          expect(response.status).to eq(422)
        end
      end

      # PUT THESE IN CONSTRUCTOR SPEC
      # it "creates a new URL object with correct path and slug" do
      #   expect { subject }
      #     .to change{Url.count}.from(0).to(1)
      #
      #   url = Url.first
      #
      #   expect(url.slug).to eq("b")
      #   expect(url.path).to eq("http://google.com")
      # end
      #
      # describe "and there is already a URL with the same path" do
      #   let!(:url) { FactoryBot.create(:url, path: "http://google.com") }
      #
      #   it "does not create a new url" do
      #     expect { subject }.to_not change { Url.count }
      #   end
      # end
    end

    describe "when the URL is not in a valid format" do
      let(:params) { { url: { path: "bad url" } } }
      before(:each) { subject }

      it "returns a 400 status code" do
        expect(response.status).to eq(422)
      end

      it "returns a bad url error message" do
        response_body = ActiveSupport::JSON.decode(response.body).stringify_keys
        expect(response_body).to eq({ "error" => "url was not shortened" })
      end
    end
  end
end
