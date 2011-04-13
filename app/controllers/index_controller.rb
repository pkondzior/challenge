class IndexController < ApplicationController
  def form
    @item = Item.new
  end

  def upload
    if params[:item] && params[:item][:file] && !params[:item][:file].blank?
      source = params[:item][:file].path
      dest = Rails.root.join('tmp', params[:item][:file].original_filename)
      FileUtils.cp(source, dest)
      render(:json => dest)
    else
      render(:json => {:error_msg => 'Upload form error, try again'}.to_json)
    end
  rescue
    render(:json => {:error_msg => 'Application Error'}.to_json)
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
