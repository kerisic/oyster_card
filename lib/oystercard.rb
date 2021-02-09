class OysterCard # rubocop:todo Style/Documentation
  DEFAULTBALANCE = 0
  MAXBALANCE = 90
  MINFARE = 1

  attr_reader :balance

  def initialize(balance = DEFAULTBALANCE)
    @balance = balance
    @in_use = false
  end

  def top_up(top_up_value)
    @balance += top_up_value
    raise "Your balance cannot be over £#{MAXBALANCE}" if @balance > MAXBALANCE
  end

  def deduct(money_spent)
    @balance -= money_spent
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise "Insufficient funds. Minimum of #{MINFARE} required." if @balance < MINFARE
    @in_use = true 
  end

  def touch_out
    @in_use = false
  end
end
