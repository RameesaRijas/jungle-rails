class UserMailer < ApplicationMailer

  def order_confirmation(order)
    @order = order
    mail(to: @order.email, subject: "Order Confirmation (#{@order.id})")
  end
end
