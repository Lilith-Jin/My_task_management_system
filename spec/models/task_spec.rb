require "rails_helper"

RSpec.describe Task, :type => :model do
  context "with task validation" do
    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without a title" do
        subject.title = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without a description" do
        subject.description = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without a start_date" do
        subject.start_date = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without a end_date" do
        subject.end_date = nil
        expect(subject).to_not be_valid
    end
  end
end