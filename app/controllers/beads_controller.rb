class BeadsController < ApplicationController
  before_action :set_bead, only: [:show, :edit, :update]

  def index
    @beads = current_user.beads
  end

  def show
    @photos = @bead.photos

    @booked = Order.where("bead_id = ? AND user_id = ?", @bead.id, current_user.id).present? if current_user

    @reviews = @bead.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @bead = current_user.beads.build
  end

  def create
    @bead = current_user.beads.build(bead_params)

    if @bead.save
      
      if params[:images]
        params[:images].each do |image|
          @bead.photos.create(image: image)
        end
      end

      @photos = @bead.photos
      redirect_to beads_path(@bead), notice: "Saved..."
    else
      render :new
    end
  end

  def edit
    if current_user.id == @bead.user.id
      @photos = @bead.photos
    else
      redirect_to root_path, notice: "You don't have permission."
    end
  end

  def update
    if @bead.update(bead_params)

      if @bead.save
        if params[:images]
          params[:images].each do |image|
            @bead.photos.create(image: image)
          end
        end

      redirect_to bead_path(@bead), notice: "Updated..."
      else
        render :edit
      end
    end
  end

  private
    def set_bead
      @bead = Bead.find(params[:id])
    end

    def bead_params
      params.require(:bead).permit(:listing_name, :summary, :waist_size, :price, :active)

    end
end