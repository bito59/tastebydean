class OrderMailer < ApplicationMailer
	default from: "tastebydean@gmail.com"

	def confirm_order(user, order)
		@user = user
		@order = order
		@order_lines = @order.order_lines
		attachments['Dean-Aide aux mesures.pdf'] = File.read('app/assets/pdf/Dean-Aide aux mesures.pdf')
		mail(to: @user.email, bcc: "tastebydean@gmail.com", subject: 'Votre commande Dean n° ' + @order.serial + ' est confirmée')
	end

end
