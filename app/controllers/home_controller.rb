class HomeController < ApplicationController
  def index
  	@unicorn = Unicorn.new
  		# silly.  so the railsy form tag stuff works
  end

  def map
  end

end
