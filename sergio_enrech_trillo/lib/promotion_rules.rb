class PromotionRules
  include Enumerable

  def initialize(*promotions)
    @all = promotions
  end

  def add(promotion)
    raise "error, not a promotion" unless promotion.is_a?(Promotion)
    raise "can't add another volume discount rule" if duplicated_volume_discount?
    all << promotion
  end

  def remove(promotion_id)
    all.delete_if{ |promo| promo.id == promotion_id}
  end

  def each(&block)
    all.each(&block)
  end

  def empty?
    @all.empty?
  end

  private

  attr_reader :all

  def duplicated_volume_discount?
    all.count{ |promo| promo.type == :"vol_discount"} == 1
  end

end