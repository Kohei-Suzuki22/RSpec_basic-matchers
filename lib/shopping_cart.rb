class ShoppingCart 
  def initialize 
    @items = []
  end
  def add(item)
    raise "added item is nil." if item.nil?
    @items << item
  end
end