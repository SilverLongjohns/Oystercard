require "journey"

describe Journey do
    
    let(:entry_station){double :station}
    let(:exit_station){double :station}
    
    it "can start a journey" do
        expect(subject).to respond_to :start
    end
    
    it "saves a starting station" do
        journey = Journey.new(entry_station)
        expect(journey.start).to eq entry_station
    end
    
    #it "saves an ending station" do
    #    journey = Journey.new(entry_station)
    #    journey.end(exit_station).to eq exit_station
    #end
    
    it "saves a complete journey" do
        journey = Journey.new(entry_station)
        journey.end(exit_station)
        expect(journey.complete?).to be_truthy
    end
    
    it "can calculate the fare for a completed journey" do
        journey = Journey.new(entry_station)
        journey.end(exit_station)
        expect(journey.charge_fare).to eq 1
    end
    
    it "can calculate the fare for an incomplete journey" do
        journey = Journey.new
        journey.end(exit_station)
        expect(journey.charge_fare).to eq 6
    end
end