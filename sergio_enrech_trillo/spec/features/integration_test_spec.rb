describe "integration test" do

  let(:item1) { Item.new(code: :"001", name: "Lavender heart", price: 9.25) }
  let(:item2) { Item.new(code: :"002", name: "Personalised cufflinks", price: 45) }
  let(:item3) { Item.new(code: :"003", name: "Kids T-shirt", price: 19.95) }
  let(:promo1) { Promotion.new(id: :promo1, type: :"multiple_buy", params: { code: :"001", quantity: 2, promo_price: 8.50 }) }
  let(:promo2) { Promotion.new(id: :promo2, type: :"vol_discount", params: { min_purchase: 60, discount: 0.1 }) }
  let(:promo3) { Promotion.new(id: :promo3, type: :"multiple_buy", params: { code: :"002", quantity: 2, promo_price: 40 }) }
  let(:rules) { PromotionRules.new(promo1,promo2,promo3) }
  let(:co) { Checkout.new(basket: Basket.new, promo_rules: rules) }

  before do
    def format_price(price)
      "£#{format('%.2f', price)}"
    end
    @discount = 0.1
  end

  context("checkout") do
    it "sum of items with no promo rules fulfilled" do
      co.scan(item1)
      co.scan(item2)
      expect(co.total).to eq format_price(item1.price+item2.price)
    end

    it "basket with code 001 fulfilling bundle promo gets discouted unit price" do
      co.scan(item1)
      co.scan(item1)
      expect(co.total).to eq format_price(2*item1.price)
    end

    it "basket get 2 items bundle discount AND discount volume" do
      co.scan(item1)
      co.scan(item1)
      co.scan(item2)
      co.scan(item2)
      expect(co.total).to eq format_price((2*item1.price+2*item2.price)*(1-@discount))
    end

    it "same basket as above in different order gets same result" do
      co.scan(item1)
      co.scan(item2)
      co.scan(item1)
      co.scan(item2)
      expect(co.total).to eq format_price((2*item1.price+2*item2.price)*(1-@discount))
    end
  end

  context "test data" do
    it "example 1" do
      co.scan(item1)
      co.scan(item2)
      co.scan(item3)
      expect(co.total).to eq format_price((item1.price+item2.price+item3.price)*(1-@discount))
    end

    it "example 2" do
      co.scan(item1)
      co.scan(item3)
      co.scan(item1)
      expect(co.total).to eq format_price(2*item1.price+item3.price)
    end

    it "example 3" do
      co.scan(item1)
      co.scan(item2)
      co.scan(item1)
      co.scan(item3)
      expect(co.total).to eq format_price((2*item1.price+item2.price+item3.price)*(1-@discount))
    end

  end

end