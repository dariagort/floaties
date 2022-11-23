class FloatiesController < ApplicationController
  def index
    @floaties = Floaty.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @floaties.geocoded.map do |floaty|
      {
        lat: floaty.latitude,
        lng: floaty.longitude,
        # info_window: render_to_string(partial: "info_window", locals: { flat: floaty }),
        # image_url: helpers.asset_url("marker_logo.png")
      }
    end
  end

  def show
    @floaty = Floaty.find(params[:id])
  end

  def new
    @floaty = Floaty.new
  end

  def create
    @floaty = Floaty.new(floaty_params)
    @floaty.user = current_user
    if @floaty.save
      redirect_to floaty_path(@floaty)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def floaty_params
    params.require(:floaty).permit(:title, :category, :details, :price, :city, :address, :photo)
  end
end
