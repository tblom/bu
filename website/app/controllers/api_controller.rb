class ApiController < ApplicationController
	#
	# endpoints for ios http access etc
	#
	def index
		# return json for unicorns.  eventually this would take a location and return the
		# unicorns within some distance.
		@server_address = request.protocol + request.domain + ":" + request.port.to_s
		u = Unicorn::get_geojson @server_address
		render json: u
	end
end


