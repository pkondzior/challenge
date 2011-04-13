class IndexController < ApplicationController
  def form
    respond_to do |format|
       @file_resource = FileResource.new
      format.html do

      end
      format.js do

      end
    end
  end

end
