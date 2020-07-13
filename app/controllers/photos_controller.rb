class PhotosController < ApplicationController
  def destroy
    @photo = Photo.find(params[:id])
    bead = @photo.bead

    @photo.destroy
    @photos = Photo.where(bead_id: bead.id)
    respond_to :js
  end
end