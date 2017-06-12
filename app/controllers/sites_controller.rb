class SitesController < ApplicationController
  def create
    @site = Site.new(site_params)

    if @site.save
      render json: @site
    else
      render json: {errors: @site.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def site_params
    params.permit(:name, :uid, :recipient)
  end
end
