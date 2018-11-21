module Api
  module V1
    class UrlsController < ApplicationController
      def url_params
        params.require(:url).permit(:path)
      end
      private :url_params

      def index
        @urls = Url.order(hit_count: :desc).limit(100)
        render "url/index"
      end

      def create
        @url = UrlConstructor.create!(url_params["path"])

        if @url.errors.empty?
          return render json: @url, status: :ok
        else
          log_msg = "Error creating URL. URL parameter: #{url_params} URL Object: #{@url.to_json}"
          Rails.logger.error log_msg
          return render json: { error: "url was not shortened" }, status: :unprocessable_entity
        end
        # if !@url.nil? && @url.save
        #   return render json: @url, status: :ok
        # else
        #   log_msg = "Error creating URL. URL parameter: #{url_params} URL Object: #{@url.to_json}"
        #   Rails.logger.error log_msg
        #   return render json: { error: "url was not shortened" }, status: :unprocessable_entity
        # end
      end
    end
  end
end
