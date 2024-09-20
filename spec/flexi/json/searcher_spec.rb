require "spec_helper"

RSpec.describe Flexi::Json::Searcher do
  let(:data) { Flexi::Json::Loader.new("./spec/data/dataset.json").load_data }

  describe "#search" do
    subject { described_class.new(data) }

    context "for a datasets.json file" do
      context "when searching against a dataset's name" do
        context "when there is a match" do
          it "returns the matched dataset" do
            result = subject.search("john", ["full_name"])
            expect(result).not_to eq []
            expect(result.first.full_name.downcase).to match(/john/)
          end

          it "returns a collection of Dataset object" do
            result = subject.search("john", ["full_name"])
            expect(result.first.class).to eq Flexi::Json::Dataset
          end
        end

        context "when there is no match" do
          it "returns an empty result" do
            result = subject.search("nonexistent", ["full_name"])
            expect(result).to eq []
          end
        end
      end

      context "when searching against a dataset's email" do
        context "when there is a match" do
          it "returns the matched dataset" do
            result = subject.search("michael", ["email"])
            expect(result).not_to eq []
            expect(result.first.email.downcase).to match(/michael/)
          end

          it "returns a collection of dataset object" do
            result = subject.search("michael", ["email"])
            expect(result.first.class).to eq Flexi::Json::Dataset
          end
        end

        context "when there is no match" do
          it "returns an empty result" do
            result = subject.search("nonexistent", ["email"])
            expect(result).to eq []
          end
        end
      end

      context "when no field is passed" do
        context "when there is a match" do
          it "searches for all searchable fields" do
            result = subject.search("william")
            expect(result).not_to eq []
            expect(result.first.email.downcase).to match(/william/)
          end
        end

        context "when there is no match" do
          it "returns an empty result" do
            result = subject.search("nonexistent")
            expect(result).to eq []
          end
        end
      end
    end

    context "for a different dataset" do
      let(:data) { Flexi::Json::Loader.new("./spec/data/different_dataset.json").load_data }
      it "works as well" do
        result = subject.search("Godfather")
        expect(result).not_to eq []
      end
    end

    context "for invalid file" do
      let(:data) { Flexi::Json::Loader.new("./spec/data/dataset.csv").load_data }
      it "has empty data" do
        expect(subject.data).to eq []
      end
    end

    context "for file not found" do
      let(:data) { Flexi::Json::Loader.new("./spec/data/nonexistent.json").load_data }
      it "has empty data" do
        expect(subject.data).to eq []
      end
    end
  end

  describe "#find_duplicates" do
    subject { described_class.new(data) }

    context "when there is a duplicate" do
      it "returns the duplicate emails" do
        expect(subject.find_duplicates("email").size).to eq 2
      end

      it "returns a collection of Dataset object" do
        expect(subject.find_duplicates("email").first.class).to eq Flexi::Json::Dataset
      end
    end

    context "when there is no duplicate" do
      let(:data) { Flexi::Json::Loader.new("./spec/data/unique_dataset.json").load_data }
      it "returns an empty array" do
        expect(subject.find_duplicates("email")).to eq []
      end
    end

    context "when passing a non-existent json key" do
      it "returns an empty array" do
        expect(subject.find_duplicates("idontexist")).to eq []
      end
    end
  end

  describe "#display_results" do
    context "when there is no data" do
    end

    context "when there is data" do
      it "displays the datasets' information" do
      end
    end
  end
end
