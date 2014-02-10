class ApiController < ApplicationController
	before_action :api_token_check
	respond_to :json

	def foobar
		puts "FOOBAR API params=#{params.inspect}"

		z = []
		Topic.all.each do |t|
			z << { name: t.name }
		end

	    render :status=>200, :json=>{:response => z}
	end

private

	def api_token_check
		unless params[:api_token] == 'helloworld'
			return head(:unauthorized, :reason => 'Bad API token')
		end
	end

end
