class OysterCard
DEFAULTBALANCE = 0

attr_reader :balance

  def initialize(balance = DEFAULTBALANCE)
    @balance = balance
  end

end
