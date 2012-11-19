class Player
  attr_accessor :name, :inventory, :shipped, :backlog, :balance
  attr_reader :order

  INVENTORY_COST = 0.5
  BACKLOG_COST   = 1

  def initialize(name = 'player')
    self.name      = name
    self.inventory = 12
    self.shipped   = 0
    self.backlog   = 0
    self.balance   = 0
    @order     = 4
  end

  def deliver(shipment, order)
    deliver_shipment(shipment)
    place_order(order)
  end

  def deliver_shipment(shipment)
    self.inventory += shipment
  end

  def place_order(order)
    self.backlog   += order
    if backlog > inventory
      self.shipped = inventory
    else
      self.shipped = backlog
    end
    self.inventory -= shipped
    self.backlog   -= shipped
    self.balance   -= (inventory * INVENTORY_COST) + (backlog * BACKLOG_COST)
  end

  def deliver_shipment_to(upstream)
    upstream.deliver_shipment(order)
  end

  def to_s
    {
      name:      name,
      inventory: inventory,
      shipped:   shipped,
      backlog:   backlog,
      balance:   balance
    }
  end
end
