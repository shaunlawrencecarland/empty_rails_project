class HomeController < ApplicationController
  def index
    @urls = Url.order(hit_count: :desc).limit(100)
    render "home/index"
  end
end
