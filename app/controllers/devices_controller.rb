class DevicesController < ApplicationController
  KEYS_COUNT = 10

  def create
    @device = Device.create
    @tokens = (0...KEYS_COUNT).map do |sequence|
      @device.device_access_tokens.create(sequence: sequence)
    end

    render json: {
      access_tokens: @tokens,
      device: @device
    }
  end
end
