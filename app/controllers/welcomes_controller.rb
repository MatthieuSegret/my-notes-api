class WelcomesController < ApplicationController
  def hello
    @message = "world"
    render json: { message: "Hello #{@message} !" }
  end
end
