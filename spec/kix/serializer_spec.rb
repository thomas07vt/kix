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

    context "when a serializer is subclassed" do
      let(:child_serializer) do
        Class.new(serializer) do
          attribute :child

          def child
            true
          end
        end
      end

      it "inherits the parents attributes" do
        expect(child_serializer.new(object).as_json).to eq({
        "name" => "John",
        "email" => "john@example.com",
        "phone" => "N/A",
        "child" => true
      })
      end
    end
  end
end
