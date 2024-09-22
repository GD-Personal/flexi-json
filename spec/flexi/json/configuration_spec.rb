require "spec_helper"

RSpec.describe Flexi::Json::Configuration do
  subject { described_class.instance }
  describe "#initialize" do
    it "sets the default configurations" do
      expect(subject.exact_match_search).to eq false
      expect(subject.match_all_fields).to eq false
    end
  end

  describe "#default_match_options" do
    it "returns the default match settings" do
      expectation = {match_all: false, exact_match: false}
      expect(described_class.default_match_options).to match(expectation)
    end
  end
end
