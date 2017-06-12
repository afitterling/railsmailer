class SitesController < ApplicationController
  before_action :assign_site, only: :deliver
  def create
    @site = Site.new(site_params)

    if @site.save
      render json: @site
    else
      render json: {errors: @site.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def deliver
    SiteMailer.email(@site.id, params[:email], params[:message], params[:name],
                     params[:address], params[:phone]).deliver_later
    render json: {status: "ok"}
  end

  private

  def site_params
    params.permit(:name, :uid, :recipient)
  end

  def assign_site
    @site = Site.find_by(uid: params[:uid])
    render json: {errors: ["Site not found"]}, status: :not_found unless @site
  end
end
