class PublishersController < ApplicationController
  def index
    @publishers = Publisher.all
  end
  
  def show
    @publisher = Publisher.find(params[:id])
    @titles = @publisher.titles
  end
end
