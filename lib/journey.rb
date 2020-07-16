class Journey
    
    FARE = 1
    PENALTY_FARE = 6
    
    attr_reader :entry_station
    def initialize
        @entry_station = nil
    end
    
    def start(station)
        @entry_station = station
    end
    
    def end(exit_station)
        @exit_station = exit_station
    end
    
    def complete?
        @entry_station != nil && @exit_station != nil
    end
    
    def charge_fare
        complete? ? FARE : PENALTY_FARE
    end
end