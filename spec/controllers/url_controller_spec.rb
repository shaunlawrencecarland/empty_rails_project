require 'rails_helper'
RSpec.describe Api::V1::UrlsController, type: :controller do

  describe "#create" do
    let(:subject) { post :create, params: params }
    describe "when the URL is in valid format" do
      let(:params) { { url: { path: "google.com",} } }

      it "returns a 302 response" do
        subject
        expect(response.status).to eq(302)
      end

      it "sets the success flash message telling the user the slug" do
        subject
        expect(flash[:success]).to match(/URL shortened.  The slug is: b/)
      end

      describe "and the URL already exists" do
        let!(:url) { FactoryBot.create(:url, path: "google.com", slug: "foo") }

        it "sets the warning flash message with the URL already exists message" do
          subject
          expect(flash[:warning]).to match(/URL google.com already exists.  Its slug is foo/)
        end
        it "returns a 302 status code" do
          subject
          expect(response.status).to eq(302)
        end
      end
    end

    describe "when the URL is not in a valid format" do
      let(:params) { { url: { path: "bad url" } } }
      before(:each) { subject }

      it "returns a 302 status code" do
        expect(response.status).to eq(302)
      end

      it "sets the warning flash message with the URL is invalid message" do
        subject
        expect(flash[:warning]).to match(/URL is in an invalid format/)
      end
    end
  end
end
