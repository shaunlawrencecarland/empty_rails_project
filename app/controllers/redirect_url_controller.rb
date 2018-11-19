class RedirectUrlController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    message = "URL with slug: '#{slug}' was not found"
    render json: { error: message }, status: 404
  end

  def index
    # test to see if the slug is valid
      # if not, return :unprocessable_entity status
    # test to see if the slug exists in the DB
      # if not, return :unprocessable_entity status
    unless Url.valid_slug?(slug)
      render json: {error: "Slug not valid.  Slug must contain only alphanumeric characters"}, status: :unprocessable_entity
    end

    url_id = UrlHelper.decode(slug)
    url = Url.find(url_id)

    redirect_to url.path, status: 301
  end

  private

  def slug
    params.require(:slug)
  end
end
