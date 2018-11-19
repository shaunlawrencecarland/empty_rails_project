class RedirectUrlController < ApplicationController
  def index
    render json: {slug: params[:slug]}, status: :ok
  end
end
