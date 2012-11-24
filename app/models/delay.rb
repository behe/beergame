class Delay
  attr_accessor :upstream, :downstream

  def initialize
    @order_queue = [4]
    @shipment_queue = [4]
  end

  def receive_shipment
    deliver_shipment(@downstream.receive_shipment) if @downstream && @downstream.kind_of?(Delay)
    @shipment_queue.shift
  end

  def deliver_shipment(shipment)
    @shipment_queue << shipment
  end

  def inventory
    @shipment_queue.first
  end

  def receive_order
    @order_queue.shift
  end

  def place_order amount
    @order_queue << amount
  end

  def order
    @order_queue.first
  end
end