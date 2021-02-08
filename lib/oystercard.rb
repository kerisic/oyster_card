class OysterCard
DEFAULTBALANCE = 0
MAXBALANCE = 90

attr_reader :balance

  def initialize(balance = DEFAULTBALANCE)
    @balance = balance
  end

  def top_up(top_up_value)
    @balance = @balance + top_up_value
    fail "Your balance cannot be over £#{MAXBALANCE}" if @balance > MAXBALANCE
  end

end
