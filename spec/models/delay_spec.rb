require_relative '../../app/models/delay'

describe Delay do
  it "should have default order of 4" do
    subject.order.should == 4
  end

  it "should order whatever is shipped" do
    subject.deliver_shipment 8
     subject.order.should == 8
  end
end
