require 'rails_helper'
RSpec.describe Url, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "self.valid_url?" do
    describe "when the URL is valid" do
      it "returns true" do
        expect(described_class.valid_url?("http://www.google.com")).to eq(true)
      end
    end
  end
end
