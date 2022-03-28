# frozen_string_literal: true

module API
  module V1
    module Bearers
      class StocksController < API::V1::Bearers::ApplicationController
        def create
          stock = current_bearer.stocks.build(stock_params)

          if stock.save
            render(json: stock)
          else
            render(json: stock.errors.full_messages)
          end
        end

        private

        def stock_params
          params.require(:stock).permit(:name)
        end
      end
    end
  end
end
