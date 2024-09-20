require "spec_helper"
require "json"

RSpec.describe Flexi::Json::Loader do
  describe "#load_data" do
    subject { described_class.new(dataset).load_data }

    context "for a given data" do
      context "which is a local file path" do
        let(:dataset) { "./spec/data/dataset.json" }
        it "loads the dataset" do
          expect(subject).not_to eq []
          expect(subject.first.class).to eq Flexi::Json::Dataset
        end
      end

      context "which is a non-existent file path" do
        let(:dataset) { "./spec/data/nonexistent.json" }
        it "returns an empty result" do
          expect(subject).to eq []
        end
      end

      context "which is a valid json object" do
        let(:dataset) { {name: "John", address: "Sydney Australia"}.to_json }
        it "loads the dataset" do
          expect(subject).not_to eq []
          expect(subject.first.class).to eq Flexi::Json::Dataset
        end
      end

      context "which is an invalid json object" do
        let(:dataset) { {name: "John", address: "Sydney Australia"} }
        it "rturns an empty result" do
          expect(subject).to eq []
        end
      end

      context "which is url to a json data" do
        let(:dataset) { "https://raw.githubusercontent.com/GD-Personal/flexi-json/main/spec/data/dataset.json" }
        it "works" do
          expect(subject).not_to eq []
          expect(subject.first.class).to eq Flexi::Json::Dataset
        end
      end

      context "which is url to an invalid json data" do
        let(:dataset) { "https://raw.githubusercontent.com/GD-Personal/flexi-json/main/spec/data/dataset.csv" }
        it "works and returns []" do
          expect(subject).to eq []
        end
      end
    end
  end
end
