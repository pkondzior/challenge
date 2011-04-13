class IndexController < ApplicationController
  def form
    @item = Item.new(params[:item])
  end

  def upload
    if params[:user_file] && params[:user_file].any? && params[:user_file].first.path
      source = params[:user_file].first.path
      dest = Rails.root.join('public', 'files', params[:user_file].first.original_filename)
      FileUtils.cp(source, dest)
      render(:text => dest)
    else
      render(:nothing => true)
    end
  end

  def show
    @item = Item.new(params[:item])
  end

end
