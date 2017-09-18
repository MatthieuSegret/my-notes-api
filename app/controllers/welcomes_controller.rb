class WelcomesController < ApplicationController
  def hello
    render json: { message: 'Hello world !' }
  end
end
