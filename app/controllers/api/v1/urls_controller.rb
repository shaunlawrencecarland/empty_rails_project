module Api
  module V1
    class UrlsController < ApplicationController
      # TODO: Can I make this better??
      def create_url_params
        params.require(:url)
      end
      private :create_url_params

      def create
        unless Url.valid_url?(create_url_params[:url])
          return render json: { error: "input url is not valid" }, status: :unprocessable_entity
        end

        ActiveRecord::Base.transaction do
          @url = Url.new(path: create_url_params[:url])
          @url.save!
          @url.slug = UrlHelper.encode(@url.id)
        end

        if !@url.nil? && @url.save
          flash[:success] = "Short URL Created!  The slug is #{@url.slug}"
          redirect_to :root
          # return redirect_to "home#index"

          # return render json: @url, status: :ok
        else
          log_msg = "Error creating URL. URL parameter: #{create_url_params} URL Object: #{@url.to_json}"
          Rails.logger.error log_msg
          return render json: { error: "url was not shortened" }, status: :unprocessable_entity
        end
      end
    end
  end
end
