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
      expect{ oyster.top_up(1) }.to raise_error "Balance at capacity: 90"
    end
    
    it "can have money deducted from it" do
      subject.top_up(50)
      subject.deduct(40)
      expect(subject.balance).to eq 10
    end
  end
  
  it "registers the beginning of a journey" do
    subject.touch_in
    expect(subject.status).to eq 1
  end
  
  it "registers the end of a journey" do
    subject.touch_in
    subject.touch_out
    expect(subject.status).to eq 0
  end
  
  it "determines whether or not we are currently on a journey" do
    subject.touch_in
    expect(subject.in_journey?).to eq true
  end
end