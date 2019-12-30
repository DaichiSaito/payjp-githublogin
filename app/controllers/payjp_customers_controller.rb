require 'payjp'
class PayjpCustomersController < ApplicationController
  def create
    Payjp::api_key = Rails.application.credentials.dig(:payjp, :private_key)
    customer = Payjp::Customer.create(card: params['payjp-token'], email: current_user.email, metadata: { name: current_user.name })
    current_user.create_payjp_customer(customer_id: customer.id, last4: customer.cards.data[0].last4, exp_year: customer.cards.data[0].exp_year, exp_month: customer.cards.data[0].exp_month, name: customer.cards.data[0].name)
    redirect_to new_subscription_path, notice: 'カードを登録しました'
  end
end
