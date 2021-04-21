require "spec_helper"

RSpec.describe Kix::Serializer do
  describe "#as_json" do
    let(:serializer) do
      Class.new(described_class) do
        attributes :name, :email, :phone, :skippable

        def phone
          _object.phone_number || "N/A"
        end

        def skippable
          throw(:skip)
        end
      end
    end

    let(:object) do
      Struct.new(:name, :email, :phone_number).new("John", "john@example.com", nil)
    end

    it "serializes the object correctly" do
      expect(serializer.new(object).as_json).to eq({
        "name" => "John",
        "email" => "john@example.com",
        "phone" => "N/A"
      })
    end
  end
end
