class Oystercard
  attr_reader :balance, :status
  
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  
  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end
  
  def top_up(amount)
    raise "Balance at capacity: #{MAXIMUM_BALANCE}" if @balance >= MAXIMUM_BALANCE
    @balance += amount
  end
  
  def deduct(amount)
    @balance -= amount
  end
  
  def touch_in
    @status = 1
  end
  
  def touch_out
    @status = 0
  end
  
  def in_journey?
    return true if @status == 1
    return false if @status == 0
  end
end