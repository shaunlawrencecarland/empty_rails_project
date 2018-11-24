module Api
  module V1
    class UrlsController < ApplicationController
      def index
        @urls = Url.order(hit_count: :desc).limit(100)
        render "url/index"
      end

      def create
        @url = UrlConstructor.create!(url_params["path"])

        if @url.errors.empty?
          flash[:success] = "URL shortened.  The slug is: #{@url.slug}"
          redirect_to root_path
        else
          flash[:error] = @url.errors[:path].inject{ |str, error| str.concat(error) }
          redirect_to root_path
        end
      end

      private
      def url_params
        params.require(:url).permit(:path)
      end
    end
  end
end
