module Api
  module V1
    class UrlsController < ApplicationController
      # TODO: Can I make this better??
      def create_url_params
        params.require(:url)
      end
      private :create_url_params

      def create
        if Url.valid_url?(create_url_params)
          render json: { url: create_url_params }, status: :ok
        else
          render json: { error: "input url is not valid" }, status: :unprocessable_entity
        end
      end
    end
  end
end
