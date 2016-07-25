class Calculations

  def initialize(basket, promo_rules)
    @basket = basket
    @promo_rules = promo_rules
    @discount = 0
    @min_buy = -1
  end

  def total()
    return basket.sum.round(2) if promo_rules.nil?
    process_multiple_buys
    result = basket.sum
    process_discount_rule
    result > min_buy ? result *= (1-discount) : result
  end

  private

  attr_reader :discount, :min_buy, :basket, :promo_rules

  def process_discount_rule
    discount_rule = promo_rules.select { |rule| rule.type == :vol_discount }
    return if discount_rule.empty?
    @discount = discount_rule.first.params[:discount]
    @min_buy = discount_rule.first.params[:min_purchase]
  end

  def process_multiple_buys
    multiple_buy_rules = promo_rules.select { |rule| rule.type == :multiple_buy }
    return if multiple_buy_rules.empty?
    multiple_buy_rules.each do |rule|
      update_unit_prices(rule.params[:code], rule.params[:quantity],
        rule.params[:promo_price])
    end

  end

  def update_unit_prices(code, qty, promo_price)
    if basket.count {|item| item.code == code } >= qty
      basket.change_price(code, promo_price)
    end
  end



end