class Production
  def initialize
    @order_queue = [4, 4]
  end

  def receive_shipment
    @order_queue.shift
  end

  def order amount
    @order_queue << amount
  end
end