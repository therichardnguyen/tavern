require 'spec_helper'

describe Api::V1::UploadController do
  describe "#create" do
    let(:json_file) {fixture_file_upload("files/controllers/api/v1/upload/valid_cards.json", "application/json")}
    let(:json_file_with_invalid_content) {fixture_file_upload("files/controllers/api/v1/upload/invalid_cards.json","application/json")}
    let(:non_json_file) {
      non_json = Tempfile.new(["not","json"])
      non_json.write("<html>Not a json file</html")
      non_json
    }
    
    context "when a valid json is uploaded" do
      before { post :upload, file: json_file }
      subject { response.status }
      it { is_expected.to be 200 }

      it "creates the card(s)" do
        expect(Card.count).to eq 2
      end
    end
    
    context "when an invalid json is uploaded" do
      before { post :upload, file: json_file_with_invalid_content}
      subject { response.status }
      it { is_expected.to be 422 }
      
      it "doesn't create the card(s)" do
        expect(Card.count).to eq 0
      end
    end
    
    context "when a non-json file is uploaded" do
      before { post :upload, file: non_json_file }
      subject { response.status }
      it { is_expected.to be 422 }
    end
  end
end
