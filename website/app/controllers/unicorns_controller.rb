class UnicornsController < ApplicationController

  def new
  	@unicorn = Unicorn.new
  end

  def create
    puts "UnicornsController::create"

    @unicorn = Unicorn.new(unicorn_params)

    if !@unicorn.latitude.blank? && @unicorn.save
      puts "UnicornsController::create POST save"
      redirect_to "/map?uid=#{@unicorn.id}"
    else
      puts "*** redirecting, unicorn not saved ***"
      redirect_to "/", notice: "The unicorn wasn't saved.  No GPS info in photo?"
    end
  end

  private

  def unicorn_params
    params.require(:unicorn).permit(:image, :message)
  end

end
