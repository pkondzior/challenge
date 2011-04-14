class IndexController < ApplicationController
  def form
    @item = Item.new
  end

  def upload
    @item = Item.new(params[:item])
    @item.upload_only = true
    if @item.save
      render(:json => @item.path)
    else
      render(:json => {:error_msg => 'Upload form error, try again'}.to_json)
    end
#  rescue
#    render(:json => {:error_msg => 'Application Error'}.to_json)
  end

  def show
    if request.post?
      @item = Item.new(params[:item])
      unless @item.save
        render('form')
      end
    else
      redirect_to('/form')
    end
  end

end
