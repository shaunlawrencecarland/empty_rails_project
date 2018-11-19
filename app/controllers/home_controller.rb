class HomeController < ApplicationController
  def index
    # TODO: If the URL already exists, just return that
    @urls = Url.order(hit_count: :desc).limit(100)
    render "home/index"
  end
end
