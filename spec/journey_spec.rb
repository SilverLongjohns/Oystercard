require "journey"

describe Journey do
    
    let(:entry_station){double :station}
    let(:exit_station){double :station}
    
    it "can start a journey" do
        expect(subject).to respond_to :start
    end
    
    it "saves a starting station" do
        expect(subject.start(entry_station)).to eq entry_station
    end
    
    it "saves an ending station" do
        expect(subject.end(exit_station)).to eq exit_station
    end
    
    it "saves a complete journey" do
        subject.start(entry_station)
        subject.end(exit_station)
        expect(subject.complete?).to be_truthy
    end
    
    it "can calculate the fare for a completed journey" do
        subject.start(entry_station)
        subject.end(exit_station)
        expect(subject.charge_fare).to eq Journey::FARE
    end
    
    it "can calculate the fare for an incomplete journey" do
        subject.end(exit_station)
        expect(subject.charge_fare).to eq Journey::PENALTY_FARE
    end
end