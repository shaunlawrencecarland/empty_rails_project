module Api
  module V1
    class UrlsController < ApplicationController
      # TODO: Can I make this better??
      def create_url_params
        params.require(:url).permit(:path)
      end
      private :create_url_params

      def index
        @urls = Url.order(hit_count: :desc).limit(100)
        render "url/index"
      end

      def create
        unless Url.valid_url?(create_url_params["path"])
          return render json: { error: "input url is not valid" }, status: :unprocessable_entity
        end

        ActiveRecord::Base.transaction do
          @url = Url.new(path: create_url_params["path"])
          @url.save!
          @url.slug = UrlHelper.encode(@url.id)
        end

        if !@url.nil? && @url.save
          return render json: @url, status: :ok
        else
          log_msg = "Error creating URL. URL parameter: #{create_url_params} URL Object: #{@url.to_json}"
          Rails.logger.error log_msg
          return render json: { error: "url was not shortened" }, status: :unprocessable_entity
        end
      end
    end
  end
end
