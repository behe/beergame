require_relative '../../app/models/player'
require_relative '../../app/models/customer'
require_relative '../../app/models/delay'

class Game
  attr_accessor :players

  def initialize
    self.players = [Customer.new, Player.new, Delay.new]
  end

  def deliver
    puts "Beergame"
    puts "players=#{players.inspect}"
    players.reverse.each_cons(2) do |player1, player2|
      player1.deliver_shipment_to(player2)
    end
    # 1. Receive shipment from supplier
    # 2. Receive order from customer
    # 3. Fulfil order to customer
    # 4. Send order to supplier
  end
end

describe Game do
  it "should deliver first round" do
    subject.deliver
  end
end
