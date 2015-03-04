class HomeController < ApplicationController
  def index
  	@unicorn = Unicorn.new
  		# silly.  so the railsy form tag stuff works
  end

  def map
  	@server_address = request.protocol + request.domain + ":" + request.port.to_s
  end

end
