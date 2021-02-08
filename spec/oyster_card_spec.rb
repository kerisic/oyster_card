require 'oystercard'

describe OysterCard do
  it "has a default balance of 0 when initialized" do
    expect(subject.balance).to eq(0)
  end
 it "tops up with the top up value as the argument" do
   subject.top_up(50)
   expect(subject.balance).to eq 50
 end
 it "raises an error when top up value exceeds maximum value" do
   expect { subject.top_up(91) }.to raise_error "Your balance cannot be over £90"
 end
end
