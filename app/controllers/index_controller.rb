class IndexController < ApplicationController
  def form
    @item = Item.new
  end

  def upload
    if params[:item] && params[:item][:file] && !params[:item][:file].blank?
      source = params[:item][:file].path
      dest = Rails.root.join('public', 'files', params[:item][:file].original_filename)
      FileUtils.cp(source, dest)
      render(:text => dest)
    else
      render(:nothing => true)
    end
  end

  def show
    if request.post?
      @item = Item.new(params[:item])
      unless @item.valid?
        render('form')
      end
    else
      redirect_to('/form')
    end
  end

end
