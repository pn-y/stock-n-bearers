class StockUpdater
  def self.call(stock, stock_params, bearer_params)
    return stock_update(stock, stock_params) if bearer_params[:bearer_name].nil?
    
    bearer = Bearer.find_by(name: bearer_params[:bearer_name])
    update_attrs = stock_params.dup

    if bearer
      update_attrs = update_attrs.merge(bearer_id: bearer.id)
    else
      stock.build_bearer(name: bearer_params[:bearer_name])
    end

    stock_update(stock, update_attrs)
  end
  
  def self.stock_update(stock, stock_params)
    stock.update(stock_params) 
    stock
  end
end