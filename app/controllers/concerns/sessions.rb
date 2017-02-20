module Sessions
  attr_writer :access_token

  def raw_access_token
    request.headers["X-Access-Token"]
  end

  def access_token
    @access_token ||= AccessToken.find_by(token: raw_access_token)
  end

  def require_access_token
    return render_no_access_token unless raw_access_token
    return render_invalid_access_token unless access_token
  end

  def render_no_access_token
    render json: {errors: ["X-Access-Token is empty."]}, status: :unauthorized
  end

  def render_invalid_access_token
    render json: {errors: ["X-Access-Token is invalid."]}, status: :unauthorized
  end
end
