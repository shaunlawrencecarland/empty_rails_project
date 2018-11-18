class RedirectUrlController < ApplicationController
  def index
    render json: {path: params[:path]}, status: :ok
  end
end
