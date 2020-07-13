require "oyster"

describe Oystercard do
  describe "balance" do
    it "starts at 0" do
      expect(subject.balance).to eq 0
    end
  end
end