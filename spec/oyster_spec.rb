require "oyster"

describe Oystercard do
  describe "balance" do
    it "starts at 0" do
      expect(subject.balance).to eq 0
    end
    
    it "is able to be topped up" do
      expect(subject.top_up(5)).to eq 5
    end
    
    it "has a maximum balance of 90" do
      oyster = Oystercard.new(90)
      expect{ oyster.top_up(1) }.to raise_error "Balance at capacity"
    end
  end
end