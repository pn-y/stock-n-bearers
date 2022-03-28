require 'test_helper'

class ApiV1StocksControllerTest < ActionDispatch::IntegrationTest
  test 'get index' do
    bearer = create(:bearer)
    stock_with_bearer = create(:stock, bearer: bearer)
    stock_without_bearer = create(:stock)
    stock_with_bearer_archived = create(:stock, bearer: bearer, status: 'archived')

    get api_v1_stocks_path

    assert_response :success
    assert parsed_body['stocks'].size == 1
    assert parsed_body['stocks'].first['id'] == stock_with_bearer.id
  end

  test 'patch update' do
    stock = create(:stock)
    stock_params = attributes_for(:stock)

    patch api_v1_stock_path(stock), params: { stock: stock_params }

    assert_response :success
    assert parsed_body['stock']['name'] == stock_params[:name]
  end

  test 'update stock bearer name by creating bearer' do
    stock = create(:stock)
    stock_params = { bearer_name: generate(:name) }

    assert stock.bearer.nil?
    assert Bearer.count.zero?

    patch api_v1_stock_path(stock), params: { stock: stock_params }

    assert_response :success

    stock.reload

    assert stock.bearer.name == stock_params[:bearer_name]
  end

  test 'update stock bearer name by switching bearer' do
    old_bearer = create(:bearer)
    stock = create(:stock, bearer: old_bearer)
    new_bearer = create(:bearer)
    stock_params = { bearer_name: new_bearer.name }

    assert stock.bearer == old_bearer

    patch api_v1_stock_path(stock), params: { stock: stock_params }

    assert_response :success

    stock.reload
    assert stock.bearer == new_bearer
  end

  test 'soft delete on delete destroy' do
    stock = create(:stock)

    delete api_v1_stock_path(stock)

    assert_response :success

    stock.reload

    assert stock.archived?
    assert stock.persisted?
  end
end
