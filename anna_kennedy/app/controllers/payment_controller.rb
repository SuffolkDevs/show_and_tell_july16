class PaymentController < ApplicationController
  def create
    render json: response_json, status: 200 if charge_request.save
  rescue ActiveRecord::RecordInvalid => e
    head 400
  rescue Stripe::CardError => e
    render json: error_response(e.code), status: 500
  end

  private

  def charge_request
    @charge_request ||= Stripe::CustomerChargeCreationRequest.new(charge_params)
  end

  def charge_params
    { 
      amount: params[:amount],
      currency: params[:currency],
      customer_id: params[:stripe_customer_id],
    }
  end

  def response_json
    {
      stripe_charge_id: charge_request.charge_id
    }
  end

  def error_response(code)
    { 'error_code' => code }
  end

end
