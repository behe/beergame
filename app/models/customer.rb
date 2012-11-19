class Customer
  attr_reader :order

  def initialize
    @orders = [4, 4, 4, 4]
    deliver_shipment
  end

  def deliver_shipment(shipment=nil)
    @order = @orders.shift || 8
  end
end