class ApiController < ApplicationController
  before_action :check_input_presence, only: [:show]

  def show
    scaler = Scaler.new(params[:image_dimensions], params[:bounding_box])
    # Input comes in as string, so parse the string into an array.
    scaler.parse_image_dimensions
    scaler.parse_bounding_box
    if scaler.valid?
      scaler.scale_dimensions
      render json: {
        "scaled_dimensions" => scaler.image_dimensions,
        "bounding_box" => scaler.bounding_box
      }
    else
      render json: scaler.errors.full_messages
    end
  end

  private

    def check_input_presence
      unless params[:image_dimensions] && params[:bounding_box]
        render json: "Must input image dimensions and bounding box"
      end
    end
end
