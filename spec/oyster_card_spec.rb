require 'oystercard'

describe OysterCard do
  it "has a default balance of 0 when initialized" do
    expect(subject.balance).to eq(0)
  end

end
