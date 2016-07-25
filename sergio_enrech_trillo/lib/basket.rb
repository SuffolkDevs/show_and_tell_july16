class Basket
  include Enumerable

  def initialize()
    @basket = []
  end

  def each(&block)
    basket.each(&block)
  end

  def empty?
    basket.empty?
  end

  def add(item)
    basket << item
  end

  def sum()
    basket.reduce(0) { |sum,item| sum += item.price }
  end

  def change_price(code, new_price)
    basket.select { |item| item.code == code}.map {|item| item.price = new_price }
  end

  private

  attr_reader :basket

end