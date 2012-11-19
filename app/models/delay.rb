class Delay
  def initialize
    @order = 4
  end

  def order
    @order
  end

  def deliver_shipment(shipment)
    @order = shipment
  end

  def deliver_shipment_to(upstream)
    upstream.deliver_shipment(order)
  end
end