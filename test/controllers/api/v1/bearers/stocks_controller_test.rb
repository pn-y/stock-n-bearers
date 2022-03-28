require 'test_helper'

class ApiV1BearersStocksControllerTest < ActionDispatch::IntegrationTest
  test 'post create' do
    bearer = create(:bearer)
    stock_params = attributes_for(:stock, name: name)

    post api_v1_bearer_stocks_path(bearer), params: { stock: stock_params }

    created_stock = Stock.find_by(name: stock_params[:name])

    assert_response :success
    assert created_stock.present?
    assert bearer == created_stock.bearer
  end
end
