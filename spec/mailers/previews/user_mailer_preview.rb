# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def order_confirmation
    # Set up a temporary order for the preview
    order = Order.new(email: "test@mail.com", total_cents: 99009)
    UserMailer.order_confirmation(order)
  end
end
