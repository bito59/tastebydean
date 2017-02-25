# ForestLiana::ApplicationController takes care of the authentication for you.
class Forest::ProductsController < ForestLiana::ApplicationController
  def do_it
    # Your business logic to send an email here.
    puts 'You did it with Forest ;)'
    render status: 200, json: {
		success: "Successfully created did it !"
	}.to_json
	render status: 400, json: {
		error: "Didnt do it :("
	}.to_json
  end
end