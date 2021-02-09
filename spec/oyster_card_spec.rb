require 'oystercard'

describe OysterCard do
  let(:station){ double :station }
  it 'has a default balance of 0 when initialized' do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    it 'tops up with the top up value as the argument' do
      expect { subject.top_up(20) }.to change { subject.balance }.by 20
    end

    it 'raises an error when top up value exceeds maximum value' do
      max_balance = OysterCard::MAXBALANCE
      subject.top_up(max_balance)
      message = "Your balance cannot be over £#{max_balance}"
      expect { subject.top_up 1 }.to raise_error message
    end
  end

  describe "#deduct" do
  
    it 'deducts money from balance when a journey is made' do
      subject.top_up(20)
      subject.touch_in(station)
      expect { subject.touch_out }.to change { subject.balance }.by -1
    end
  end

  describe "#in_journey?" do
    it 'returns true if still in journey' do
      subject.top_up(20)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end
  end

  # describe "#touch_in" do
  #   it 'returns true if user touched in at start of journey' do
  #     subject.top_up(20)
  #     expect(subject.touch_in(station)).to eq(true)
  #   end
  # end

  context "if card is in use" do
    it 'returns true for in_journey?' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end
  end

  context "if user has insufficient funds" do
    min_fare = OysterCard::MINFARE
    it 'returns an error when card has less than £1' do
      expect{ subject.touch_in(station) }.to raise_error "Insufficient funds. Minimum of #{min_fare} required."
    end
  end

  describe "save user start destination when they touch in" do
    it 'returns entry station' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe "Forget entry station on touch out" do
    it 'forgets entry station when user touches out' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
  end
end
