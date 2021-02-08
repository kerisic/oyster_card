class OysterCard # rubocop:todo Style/Documentation
  DEFAULTBALANCE = 0
  MAXBALANCE = 90

  attr_reader :balance

  def initialize(balance = DEFAULTBALANCE)
    @balance = balance
  end

  def top_up(top_up_value)
    @balance += top_up_value
    raise "Your balance cannot be over £#{MAXBALANCE}" if @balance > MAXBALANCE
  end

  def deduct(money_spent)
    @balance -= money_spent
  end
end
