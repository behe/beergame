require_relative '../../app/models/player'

describe Player do
  context "initial setup" do
    its(:name) { should == 'player' }
    its(:inventory) { should == 12 }
    its(:shipped) { should == 0 }
    its(:backlog) { should == 0 }
    its(:balance) { should == 0 }
    its(:order) { should == 0 }
  end

  context "initial round" do
    context "initial shipment" do
      before do
        subject.deliver_shipment 4
      end

      its(:inventory) { should == 16 }
      its(:shipped) { should == 0 }
      its(:backlog) { should == 0 }
      its(:balance) { should == 0 }

      context "initial order" do
        before do
          subject.place_order 4
        end

        its(:inventory) { should == 12 }
        its(:shipped) { should == 4 }
        its(:backlog) { should == 0 }
        its(:balance) { should == -6 }
      end
    end
  end

  context "with larger order than inventory" do
    before do
      subject.place_order 16
    end

    its(:inventory) { should == 0 }
    its(:shipped) { should == 12 }
    its(:backlog) { should == 4 }
    its(:balance) { should == -4 }
  end

  context "with backlog of 4" do
    before do
      subject.backlog = 4
    end

    context "with larger shipment than order" do
      before do
        subject.deliver_shipment(8)
        subject.place_order(4)
      end

      its(:inventory) { should == 12 }
      its(:shipped) { should == 8 }
      its(:backlog) { should == 0 }
      its(:balance) { should == -6 }
    end
  end

  context "with backlog" do
    before do
      subject.backlog = 12
      subject.deliver_shipment(4)
      subject.place_order(4)
    end

    its(:inventory) { should == 0 }
    its(:shipped) { should == 16 }
    its(:backlog) { should == 0 }
    its(:balance) { should == 0 }
  end
end