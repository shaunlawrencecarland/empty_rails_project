class RedirectUrlController < ApplicationController
  def index
    @slug = params[:slug]
    # test to see if the slug is valid
      # if not, return :unprocessable_entity status
    # test to see if the slug exists in the DB
      # if not, return :unprocessable_entity status
    unless Url.valid_slug?(params[:slug])
      render json: {error: "Slug not valid.  Slug must contain only alphanumeric characters"}, status: :unprocessable_entity
    end

    url_id = UrlHelper.decode(@slug)
    @url = Url.find(url_id)

    
    render json: {slug: params[:slug]}, status: :ok
  end
end
