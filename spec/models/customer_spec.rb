require_relative '../../app/models/customer'

describe Customer do
  it "should change order to 8 after 4 delivered shipments" do
    subject.receive_order.should == 4
    subject.deliver_shipment
    subject.receive_order.should == 4
    subject.deliver_shipment
    subject.receive_order.should == 4
    subject.deliver_shipment
    subject.receive_order.should == 4
    subject.deliver_shipment
    subject.receive_order.should == 8
  end
end
