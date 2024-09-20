require "spec_helper"

RSpec.describe Flexi::Json::Dataset do
  describe ".initialize" do
    subject { described_class.new(id: "1", name: "John Doe", email: "john.doe@gmail.com", address: "Sydney, Australia") }
    context "responds to the given attributes" do
      it { is_expected.to respond_to :attributes }
      it { is_expected.to respond_to :name }
      it { is_expected.to respond_to :email }
      it { is_expected.to respond_to :address }
    end

    context "when loading dangerous keys/attributes" do
      subject { described_class.new(object_id: "1", send: "John Doe", class: "john.doe@gmail.com") }
      it "raises an error" do
        expect { subject }.to raise_error(/Invalid key/)
      end
    end
  end

  describe "#matches?" do
    subject { described_class.new(id: "1", full_name: "John Doe", email: "john.doe@gmail.com") }

    context "when no search field is passed" do
      context "when no query is passed" do
        it "returns true" do
          expect(subject.matches?(nil)).to eq true
        end
      end

      context "when first name query matches" do
        it "returns true" do
          expect(subject.matches?("john")).to eq true
          expect(subject.matches?("ohn")).to eq true
          expect(subject.matches?("joh")).to eq true
        end
      end

      context "when last name query matches" do
        it "returns true" do
          expect(subject.matches?("do")).to eq true
          expect(subject.matches?("oe")).to eq true
          expect(subject.matches?("doe")).to eq true
        end
      end

      context "when the query does not match" do
        it "returns false" do
          expect(subject.matches?("doen")).to eq false
          expect(subject.matches?("jhn")).to eq false
          expect(subject.matches?("jhon")).to eq false
        end
      end
    end

    context "when a search field is passed" do
      subject { described_class.new(id: "1", full_name: "John Doe", email: "jdoe@gmail.com") }
      context "when no query is passed" do
        it "returns true" do
          expect(subject.matches?(nil, ["email"])).to eq true
        end
      end

      context "when query matches the search field" do
        it "returns true" do
          expect(subject.matches?("jdoe", ["email"])).to eq true
          expect(subject.matches?("jdoe@gmail.com", ["email"])).to eq true
          expect(subject.matches?("doe@gmail.com", ["email"])).to eq true
        end
      end

      context "when the query does not match the search field" do
        it "returns false" do
          expect(subject.matches?("jde", ["email"])).to eq false
          expect(subject.matches?("jdoe@gmail.com.au", ["email"])).to eq false
        end
      end
    end

    context "when a search field does not exist" do
      it "returns false" do
        expect(subject.matches?("john", ["first_name"])).to eq false
      end
    end

    context "when there is a valid and invalid search fields" do
      it "will still search against the valid field" do
        expect(subject.matches?("john", ["first_name", "email"])).to eq true
      end
    end

    context "when passing a nil search field" do
      it "falls back to the default searchable fields" do
        expect(subject.matches?("john", nil)).to eq true
      end
    end
  end
end
