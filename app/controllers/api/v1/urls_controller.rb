module Api
  module V1
    class UrlsController < ApplicationController
      # TODO: Can I make this better??
      def create_url_params
        params.require(:url)
      end
      private :create_url_params

      def create
        unless Url.valid_url?(create_url_params)
          return render json: { error: "input url is not valid" }, status: :unprocessable_entity
        end

        ActiveRecord::Base.transaction do
          @url = Url.new(path: params[:url])
          @url.save!
          @url.slug = Url.encode(@url.id)
        end

        if !@url.nil? && @url.save
          return render json: @url, status: :ok
        else
          return render json: { error: "url was not shortened" }, status: :unprocessable_entity
        end
      end
    end
  end
end
