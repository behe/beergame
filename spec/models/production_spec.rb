require_relative '../../app/models/production'

describe Production do

  it "delivers 4 the first week" do
    expect(subject.receive_shipment).to eq 4
  end

  it "delivers 4 the second week" do
    subject.receive_shipment
    expect(subject.receive_shipment).to eq 4
  end

  it "delivers requested order after two weeks delay" do
    subject.receive_shipment
    subject.order 1
    subject.receive_shipment
    subject.order 2
    expect(subject.receive_shipment).to eq 1
    expect(subject.receive_shipment).to eq 2
  end
end
