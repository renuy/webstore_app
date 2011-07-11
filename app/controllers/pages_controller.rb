class PagesController < ApplicationController
  def about
    render 'about',:layout =>'corp'
	end

  def contact
	end

  def tnc
    render 'tnc',:layout =>'corp'
	end
  
  def privacypolicy
    render 'privacypolicy',:layout =>'corp'
  end
end
