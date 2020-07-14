class Oystercard
  attr_reader :balance, :status
  
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  FARE = 1
  
  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end
  
  def top_up(amount)
    raise "Balance at capacity: #{MAXIMUM_BALANCE}" if @balance >= MAXIMUM_BALANCE
    @balance += amount
  end
  
  def touch_in
    raise "Not enough balance" if @balance < FARE
    @status = true
  end
  
  def touch_out
    deduct(FARE)
    @status = false
  end
  
  def in_journey?
    @status
  end
  
  private
  
  def deduct(amount)
    @balance -= amount
  end
end