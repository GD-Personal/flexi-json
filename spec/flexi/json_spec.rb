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
end
