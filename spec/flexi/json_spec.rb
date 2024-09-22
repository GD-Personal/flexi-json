# frozen_string_literal: true

RSpec.describe Flexi::Json do
  it "has a version number" do
    expect(Flexi::Json::VERSION).not_to be nil
  end

  describe ".configuration" do
    it "sets the configuration object" do
      expect(described_class.configuration.class).to eq Flexi::Json::Configuration
    end

    context "for default configs" do
      it "returns the default configurations" do
        expect(described_class.configuration.exact_match_search).to eq false
        expect(described_class.configuration.match_all_fields).to eq false
      end
    end
  end

  describe ".configure" do
    context "when yielded" do
      subject do
        described_class.configure do |config|
          config.exact_match_search = true
          config.match_all_fields = true
        end
        described_class
      end

      it "returns the correct configurations" do
        expect(subject.configuration.exact_match_search).to eq true
        expect(subject.configuration.match_all_fields).to eq true
      end
    end
  end

  describe "#search" do
    subject { described_class.new("./spec/data/dataset.json") }

    context "for query param" do
      it "works for string type" do
        expect(subject.search("john")).not_to eq []
      end

      it "works for array type" do
        expect(subject.search(["john"])).to eq []
      end
    end

    context "for fields param" do
      it "works for string type" do
        expect(subject.search("john", "full_name")).not_to eq []
        expect(subject.search("john", "full_name, email")).not_to eq []
      end
      it "works for array type" do
        expect(subject.search("john", ["full_name"])).not_to eq []
        expect(subject.search("john", ["full_name", "email"])).not_to eq []
      end
    end

    context "for options params" do
      it "works for match_all option" do
        options = {match_all: true}
        expect(subject.search("john", "full_name", options: options)).not_to eq []

        query = {full_name: "john", email: "some_email@gmail.com"}
        expect(subject.search(query, "full_name", options: options)).to eq []

        query = {full_name: "john", email: "john.doe"}
        expect(subject.search(query, options: options)).not_to eq []
      end

      it "works for exact_match option" do
        options = {exact_match: true}
        expect(subject.search("john", "full_name", options: options)).to eq []
        expect(subject.search("john doe", "full_name", options: options)).not_to eq []

        query = {full_name: "john", email: "john.doe"}
        expect(subject.search(query, "full_name", options: options)).to eq []
      end

      it "works for both options" do
        options = {exact_match: true, match_all: true}
        query = {full_name: "john", email: "some_email@gmail.com"}
        expect(subject.search(query, options: options)).to eq []

        query = {full_name: "john doe", email: "john.doe@gmail.com"}
        expect(subject.search(query, options: options)).not_to eq []
      end
    end
  end

  describe "#find_duplicates" do
    subject { described_class.new("./spec/data/dataset.json") }
    it "works" do
      expect(subject.find_duplicates("email").size).to eq 2
      expect(subject.find_duplicates("unknown_key").size).to eq 0
    end
  end
end
