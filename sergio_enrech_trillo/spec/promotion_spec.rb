require 'promotion'

describe Promotion do

  subject(:promotion) { described_class.new(id: :"promo1",
    type: :"multiple_buy",params: { item: :"001", price: 8.50 }) }
  let(:error_promo) { described_class.new(id: nil,
    type: :"multiple_buy",params: { item: :"001", price: 8.50 }) }
  let(:error_promo2) { described_class.new(id: :"promo1",
    type: nil,params: {  }) }
  let(:error_promo3) { described_class.new(id: :"promo1",
    type: :"multiple_buy",params: nil) }

  before do
    @id = :"promo1"
    @type = :"multiple_buy"
    @description = "2 Lavender heart, unit price 8.50"
    @params = { item: :"001", price: 8.50 }
  end

  it "with one parameter not filled, throws error" do
    expect { error_promo }.to raise_error(RuntimeError,
      "error: entry not correct")
    expect { error_promo2 }.to raise_error(RuntimeError,
      "error: entry not correct")
    expect { error_promo3 }.to raise_error(RuntimeError,
      "error: entry not correct")

  end

  it "has parameters name, description, and params" do
    expect(promotion.id).to eq @id
    expect(promotion.type).to eq @type
    expect(promotion.params).to eq @params
  end
end