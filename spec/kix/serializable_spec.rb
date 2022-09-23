require "spec_helper"

RSpec.describe Kix::Serializable do
  class UserSerializer < Kix::Serializer
    attributes :name, :email
  end

  class User
    include Kix::Serializable

    def name
      "John"
    end

    def email
      "john@example.com"
    end
  end

  describe ".include" do
    it "automatically sets the related serializer" do
      expect(User.serializer).to eq(UserSerializer)
    end
  end

  describe ".serializer" do
    class AnotherSerializer < Kix::Serializer
    end

    class Admin
      include Kix::Serializable
      serializer AnotherSerializer
    end

    it "allow you to set the serializer directly" do
      expect(Admin.serializer).to eq(AnotherSerializer)
    end
  end

  describe "#as_json" do
    it "serializes using the correct Serializer" do
      expect(User.new.as_json).to eq({ "email" => "john@example.com", "name" => "John" })
    end
  end

  context "when a class is subclassed with a parent serailizer" do
    class Guest < User
      include Kix::Serializable

      def name
        "Guest"
      end

      def email
        "guest@example.com"
      end
    end

    it "sets the parent serializer by default" do
      expect(Guest.serializer).to eq(UserSerializer)
    end
  end

  context "when a class is subclassed with a subclassed serailizer" do
    class ManagerSerializer < Kix::Serializer
    end

    class Manager < User
      include Kix::Serializable

      def name
        "Manager"
      end
    end

    it "sets the subclass serializer" do
      expect(Manager.serializer).to eq(ManagerSerializer)
    end
  end
end
