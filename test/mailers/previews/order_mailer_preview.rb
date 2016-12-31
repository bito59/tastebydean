# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
	def confirm_order_preview
		OrderMailer.confirm_order(User.first, Order.first)
	end
end
