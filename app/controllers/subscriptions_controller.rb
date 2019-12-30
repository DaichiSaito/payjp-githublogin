require 'payjp'
class SubscriptionsController < ApplicationController
  def new
    Payjp::api_key = Rails.application.credentials.dig(:payjp, :private_key)
    if current_user.payjp_customer.present?
      @customer = Payjp::Customer.retrieve(current_user.payjp_customer.customer_id)
    end
    @plans = Payjp::Plan.all
    # binding.pry
  end

  def create
    Payjp::api_key = Rails.application.credentials.dig(:payjp, :private_key)
    Payjp::Subscription.create(
        customer: current_user.payjp_customer.customer_id,
        plan:     params[:plan_id],
        )
    redirect_to new_subscription_path, notice: '購読しました'
  end

  def destroy
    Payjp::api_key = Rails.application.credentials.dig(:payjp, :private_key)
    subscription = Payjp::Subscription.retrieve(params[:subscription_id])
    subscription.cancel
    redirect_to new_subscription_path, notice: '解約しました'
  rescue # Payjp::InvalidRequestError
    redirect_to new_subscription_path, alert: '失敗！！！'
  end

  def resume
    Payjp::api_key = Rails.application.credentials.dig(:payjp, :private_key)
    subscription = Payjp::Subscription.retrieve(params[:subscription_id])
    subscription.resume
    redirect_to new_subscription_path, notice: '再開しました'
  rescue # Payjp::InvalidRequestError
    redirect_to new_subscription_path, alert: '失敗！！！'
  end

  def complete
  end
end
