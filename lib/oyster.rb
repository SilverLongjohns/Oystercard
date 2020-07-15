class Oystercard
  attr_reader :balance, :status, :entry_station, :exit_station, :journey, :log
  
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  FARE = 1
  
  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey = []
    @log = {}
  end
  
  def top_up(amount)
    raise "Balance at capacity: #{MAXIMUM_BALANCE}" if @balance >= MAXIMUM_BALANCE
    @balance += amount
  end
  
  def touch_in(station)
    raise "Not enough balance" if @balance < FARE
    @entry_station = station
    @log[:touch_in] = station
  end
  
  def touch_out(station)
    deduct(FARE)
    @entry_station = nil
    @exit_station = station
    @log[:touch_out] = station
    @journey << @log
    @log = {}
  end
  
  def in_journey?
    true unless @entry_station == nil
  end
  
  private
  
  def deduct(amount)
    @balance -= amount
  end
end