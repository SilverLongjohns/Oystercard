require "oyster"

describe Oystercard do
  describe "balance" do
    it "starts at 0" do
      expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
    end
    
    it "is able to be topped up" do
      expect(subject.top_up(5)).to eq 5
    end
    
    it "has a maximum balance of 90" do
      oyster = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
      expect{ oyster.top_up(1) }.to raise_error "Balance at capacity: #{Oystercard::MAXIMUM_BALANCE}"
    end
  end
  
  it "registers the beginning of a journey" do
    subject.top_up(Oystercard::FARE)
    subject.touch_in
    expect(subject.status).to eq true
  end
  
  it "registers the end of a journey" do
    subject.top_up(Oystercard::FARE)
    subject.touch_in
    subject.touch_out
    expect(subject.status).to eq false
  end
  
  it "determines whether or not we are currently on a journey" do
    subject.top_up(Oystercard::FARE)
    subject.touch_in
    expect(subject.in_journey?).to eq true
  end
  
  it "does not let a journey begin without at least £#{Oystercard::FARE} in balance" do
    expect{subject.touch_in}.to raise_error "Not enough balance"
  end
  
  it "deducts money upon completion of a journey" do
    subject.top_up(Oystercard::FARE)
    subject.touch_in
    expect {subject.touch_out}.to change{subject.balance}.by(-Oystercard::FARE)
  end
end