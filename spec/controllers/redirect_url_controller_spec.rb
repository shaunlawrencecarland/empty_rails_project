require 'rails_helper'
RSpec.describe RedirectUrlController, type: :controller do
  describe "#index" do
    let(:subject) { get :index, params: { slug: slug } }

    describe "when the slug is valid" do
      let(:slug) { "b" }

      describe "and there is not a url corresponding with the slug" do
        it "returns a 404 status code" do
          subject
          expect(response.status).to eq(404)
        end

        it "returns an error message telling the user that the url was not found" do
          subject

          response_body = ActiveSupport::JSON.decode(response.body).stringify_keys
          expect(response_body).to eq({ "error" => "URL with slug: 'b' was not found" })
        end
      end

      describe "and there is a url corresponding with the slug" do
        let!(:url) { FactoryBot.create(:url, path: "http://google.com", slug: "b") }

        it "returns a 301 response status" do
          subject
          expect(response.status).to eq(301)
        end

        it "redirects the user to the URL" do
          expect(subject).to redirect_to("http://google.com")
        end

        context "incrementing the count" do
          it "increments the URL's count" do
            expect { subject }.to change { url.reload.count }.from(0).to(1)
          end

          describe "when the url is not able to be saved" do
            before(:each) { allow_any_instance_of(Url).to receive(:save).and_return(false) }

            it "logs an error message" do
              expect(Rails.logger).to receive(:error)
              subject
            end
          end
        end
      end
    end

    describe "when the slug is invalid" do
      let(:slug) { "invalid/slug"  }

      it "returns a 422 status" do
        subject
        expect(response.status).to eq(422)
      end

      it "returns an error message" do
        subject

        response_body = ActiveSupport::JSON.decode(response.body).stringify_keys
        msg = "Slug not valid.  Slug must contain only alphanumeric characters"
        expect(response_body).to eq({ "error" => msg })
      end
    end
  end
end
