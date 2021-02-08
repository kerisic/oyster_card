class OysterCard
DEFAULTBALANCE = 0

attr_reader :balance

  def initialize(balance = DEFAULTBALANCE)
    @balance = balance
  end

  def top_up(top_up_value)
    @balance = @balance + top_up_value 
  end

end
