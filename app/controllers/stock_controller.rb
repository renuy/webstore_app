class StockController < ApplicationController
  def show
    stocks = Stock.find_all_by_title_id(params[:id].to_i)
    @title = Title.find(params[:id].to_i)

    stockArray = []
  
    stocks.each do |i|
      stockArray << i.to_jit
    end
    
    @stockHash = {
      'label' => ['in circulation', 'in store', 'unavailable'],
      'values' => stockArray
    }
    
    render :json => @stockHash
  rescue ActiveRecord::RecordNotFound
    @title = nil
    @stockHash = {
      'label' => ['in circulation', 'in store', 'unavailable'],
      'values' => []
    }
  end
end
