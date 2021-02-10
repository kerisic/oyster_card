require 'oystercard'

describe OysterCard do
  let(:station) { double :station }
  let(:station2) { double :station2 }

  it 'has a default balance of 0 when initialized' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
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

  describe '#deduct' do
    it 'deducts money from balance when a journey is made' do
      subject.top_up(20)
      subject.touch_in(station)
      expect { subject.touch_out(station2) }.to change { subject.balance }.by(-1)
    end
  end

  context 'if user has insufficient funds' do
    min_fare = OysterCard::MINFARE
    it 'returns an error when card has less than £1' do
      expect { subject.touch_in(station) }.to raise_error "Insufficient funds. Minimum of #{min_fare} required."
    end
  end

  describe 'user can touch in and touch out' do
    before(:each) do
      subject.top_up(1)
      subject.touch_in(station)
    end
    
    it 'can let an user touch_in at the start of journey' do
      expect(subject).to be_in_journey
    end

    it 'can let an user touch_out at the end of journey' do
      subject.touch_out(station2)
      expect(subject).not_to be_in_journey
    end
  end

  describe "saves user's destination when they travel" do
    before(:each) do
      subject.top_up(1)
      subject.touch_in(station)
    end

    it 'returns entry station upon touching-in' do
      expect(subject.entry_station).to eq station
    end

    it 'forgets entry station when user touches out' do
      subject.touch_out(station2)
      expect(subject.entry_station).to eq nil
    end

    it 'returns exit station upon touching-out' do
      subject.touch_out(station2)
      expect(subject.exit_station).to eq station2
    end

    it 'returns an empty list of journeys when no journey has been made' do
      expect(subject.journeys).to eq []
    end

    it 'creates one journey after user touches in and out' do
      subject.touch_out(station2)
      expect(subject.journeys).to eq [{ entry_station: station, exit_station: station2 }]
    end
  end
end
