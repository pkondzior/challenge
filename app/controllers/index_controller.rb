class IndexController < ApplicationController
  def form
    @item = Item.new
  end

  def upload

    if params[:item]
      @item = Item.new(params[:item])
      @item.save
      render(:json => @item.path)
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
      else
        @item.save
      end
    else
      redirect_to('/form')
    end
  end

end
