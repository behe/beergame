class Customer
  attr_reader :order_queue, :shipped

  def initialize
    @order_queue = [4, 4, 4, 4]
    @shipped = []
  end

  def receive_order
    @order_queue.shift || 8
  end

  def order
    @order_queue.first || 8
  end

  def deliver_shipment(shipment=nil)
    @shipped << shipment
  end
end