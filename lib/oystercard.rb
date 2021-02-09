class OysterCard # rubocop:todo Style/Documentation
  DEFAULTBALANCE = 0
  MAXBALANCE = 90
  MINFARE = 1

  attr_reader :balance, :entry_station

  def initialize(balance = DEFAULTBALANCE)
    @balance = balance
    @entry_station = nil
  end

  def top_up(top_up_value)
    @balance += top_up_value
    raise "Your balance cannot be over £#{MAXBALANCE}" if @balance > MAXBALANCE
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise "Insufficient funds. Minimum of #{MINFARE} required." if @balance < MINFARE
    @entry_station = station
  end

  def touch_out
    @balance -= 1
    @entry_station = nil
  end

  private
  def deduct(money_spent)
    @balance -= money_spent
  end
  
end
