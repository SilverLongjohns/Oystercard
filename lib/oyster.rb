require_relative "station"
require_relative "journey"

class Oystercard
  attr_reader :balance, :status, :entry_station, :exit_station, :journey, :log
  
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  
  def initialize(balance = DEFAULT_BALANCE, journey = Journey.new)
    @balance = balance
    @log = []
    @trip = {}
    @journey = journey
  end
  
  def top_up(amount)
    raise "Balance at capacity: #{MAXIMUM_BALANCE}" if @balance >= MAXIMUM_BALANCE
    @balance += amount
  end
  
  def touch_in(station)
    raise "Not enough balance" if @balance < Journey::FARE
    @journey.start(station)
    @trip[:touch_in] = station
  end
  
  def touch_out(station)
    @journey.end(station)
    @trip[:touch_out] = station
    @log << @trip
    @trip = {}
    deduct(journey.charge_fare)
  end
  
#  def in_journey?
#    true unless @entry_station == nil
#  end
  
  private
  
  def deduct(amount)
    @balance -= amount
  end
end