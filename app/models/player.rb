class Player
  attr_accessor :name, :inventory, :shipped, :backlog, :balance, :upstream, :downstream
  attr_reader :order

  INVENTORY_COST = 0.5
  BACKLOG_COST   = 1

  def initialize(name = 'player')
    self.name      = name
    self.inventory = 12
    self.shipped   = 0
    self.backlog   = 0
    self.balance   = 0
    @order         = 0
  end

  def next_week
    deliver_shipment(@downstream.receive_shipment)
    place_order(@upstream.receive_order)
  end

  def deliver_shipment(shipment)
    self.inventory += shipment
  end

  def place_order(order)
    self.backlog += order
    if backlog > inventory
      self.shipped = inventory
    else
      self.shipped = backlog
    end
    self.inventory -= shipped
    self.backlog   -= shipped
    @upstream.deliver_shipment(shipped) if @upstream
    self.balance   -= (inventory * INVENTORY_COST) + (backlog * BACKLOG_COST)
  end

  def to_s
    {
      name:      name,
      inventory: inventory,
      shipped:   shipped,
      backlog:   backlog,
      balance:   balance,
      order:     order
    }
  end
end
