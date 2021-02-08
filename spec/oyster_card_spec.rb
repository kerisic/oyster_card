require 'oystercard'

describe OysterCard do
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
    it 'deducts money from balance when u spend money' do
      subject.top_up(50)
      expect { subject.deduct(30) }.to change { subject.balance }.by -30
    end
  end
end
