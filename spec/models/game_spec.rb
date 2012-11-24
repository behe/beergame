require_relative '../../app/models/game'

describe Game do
  let (:game) { Game.new }

  subject { game.players.first }

  it "defaults to one player with customer and production" do
    expect(game.players.size).to eq 1
    expect(subject.upstream).to be_a Customer
    expect(subject.downstream).to be_a Production
  end

  it "adds delay between players" do
    game = Game.new(2)
    game.players.size.should eq 2

    player1 = game.players.first
    player1.upstream.should be_a Customer
    player1.downstream.should be_a Delay

    player2 = game.players.last
    player2.upstream.should be_a Delay
    player2.downstream.should be_a Production

    player1.downstream.should === player2.upstream.upstream
  end

  it "pulls shipments through delay queue" do
    game = Game.new(2)
    game.next_week
    player1 = game.players.first
    player1.inventory.should == 12
    player1.downstream.inventory.should == 4
    player2 = game.players.last
    player2.inventory.should == 12
    player2.upstream.inventory.should == 4
  end

  context "initial shipment and order" do
    before do
      game.next_week
    end

    its(:inventory) { should == 12 }
    its(:shipped) { should == 4 }
    its(:backlog) { should == 0 }
    its(:balance) { should == -6 }
  end
end
