# frozen_string_literal: true

module API
  module V1
    class StocksController < ApplicationController
      def index
        render(json: { stocks: Stock.api.with_bearer })
      end

      def update
        stock = Stock.api.find(params[:id])

        updated_stock = StockUpdater.call(stock, stock_params, bearer_params)

        if updated_stock.valid?
          render(json: { stock: stock })
        else
          render(json: stock.errors.full_messages)
        end
      end

      def destroy
        stock = Stock.api.find(params[:id])

        if stock.archived!
          head(204)
        else
          render(json: stock.errors.full_messages)
        end
      end

      private

      def stock_params
        params.require(:stock).permit(:name)
      end

      def bearer_params
        params.require(:stock).permit(:bearer_name)
      end
    end
  end
end
