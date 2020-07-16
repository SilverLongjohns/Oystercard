require "oyster"

describe Oystercard do
  let(:station) {:station}
  
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
  
  it "does not let a journey begin without at least £#{Journey::FARE} in balance" do
    expect{subject.touch_in(station)}.to raise_error "Not enough balance"
  end
  
  it "deducts money upon completion of a journey" do
    subject.top_up(Journey::FARE)
    subject.touch_in(station)
    expect {subject.touch_out(station)}.to change{subject.balance}.by(-Journey::FARE)
  end
  
  it "saves the entry station upon touch in" do
    subject.top_up(Journey::FARE)
    subject.touch_in(station)
    expect(subject.journey.entry_station).to eq :station
  end
  
  it "forgets the entry station upon touch out" do
    subject.top_up(Journey::FARE)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.entry_station).to eq nil
  end
  
  # 1. Touch out stores exit station
  # 2. Entry an exit station are paired in a hash
  # 3. Hash is added to an array
  
  it "saves the entry and exit stations upon touch_out" do
    subject.top_up(Journey::FARE)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.log).to eq [{touch_in: :station, touch_out: :station}]
  end
  
  it "has a journey list that is empty by default" do
    expect(subject.log).to eq []
  end
end