require 'oystercard'

describe OysterCard do
  it "has a default balance of 0 when initialized" do
    expect(subject.balance).to eq(0)
  end
 it "tops up with the top up value as the argument" do
   subject.top_up(200)
   expect(subject.balance).to eq 200
 end
end
