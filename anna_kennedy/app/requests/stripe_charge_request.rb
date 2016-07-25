class StripeChargeRequest < ActiveType::Object
  attribute :amount
  attribute :currency
  attribute :customer_id
  attribute :charge_id

  validates :amount, :currency, :customer_id, presence: true

  before_save :stripe_charge_request

  private

  def stripe_charge_request
    stripe_charge = Stripe::Charge.create(charge_params)

    self.charge_id = stripe_charge.id
  end

  def charge_params
    {
      amount: fractional_amount,
      currency: currency,
      customer: customer_id,
    }
  end

  def fractional_amount
    (amount.to_f * 100).to_i
  end
end
