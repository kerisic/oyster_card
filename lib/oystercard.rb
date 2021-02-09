class OysterCard # rubocop:todo Style/Documentation
  DEFAULTBALANCE = 0
  MAXBALANCE = 90
  MINFARE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize(balance = DEFAULTBALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @journeys = []
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

  def touch_out(station)
    @balance -= 1
    @exit_station = station
    journey = {entry_station: @entry_station, exit_station: @exit_station}
    @journeys << journey
    @entry_station = nil
  end

  private
  def deduct(money_spent)
    @balance -= money_spent
  end

end
