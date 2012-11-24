class Game
  attr_accessor :players

  def initialize(players = 1)
    actors = players.times.map do |n|
      x = [Player.new("player#{n+1}")]
      x = [Delay.new, Delay.new] + x  unless n == 0
      x
    end.flatten

    actors = [Customer.new] + actors + [Production.new]
    actors.each_cons(3) do |upstream, actor, downstream|
      actor.upstream = upstream
      actor.downstream = downstream
    end

    self.players = actors.select{|x| x.kind_of? Player}
  end

  def next_week
    players.each do |player|
      player.next_week
    end
  end
end
