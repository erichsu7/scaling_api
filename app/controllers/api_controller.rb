class ApiController < ApplicationController
  def show
    # Parse arrays in query string into Ruby array objects. A regex might
    # accomplish this more succinctly, but I think maintaining every element
    # is easier for validation purposes.
    # image_dimensions =
    #   params[:image_dimensions][1..-2].split(",").map {|dim| dim.to_i}
    # bounding_box =
    #   params[:bounding_box][1..-2].split(",").map {|dim| dim.to_i}
    #
    # i = 0
    # while i < image_dimensions.length
    #   x_scalar = bounding_box[0].to_f / image_dimensions[i]
    #   y_scalar = bounding_box[1].to_f / image_dimensions[i + 1]
    #
    #   if x_scalar < y_scalar
    #     image_dimensions[i] = (image_dimensions[i] * x_scalar).to_i
    #     image_dimensions[i + 1] = (image_dimensions[i + 1] * x_scalar).to_i
    #   else
    #     image_dimensions[i] = (image_dimensions[i] * y_scalar).to_i
    #     image_dimensions[i + 1] = (image_dimensions[i + 1] * y_scalar).to_i
    #   end
    #
    #   i += 2
    # end

    scaler = Scaler.new(params[:image_dimensions], params[:bounding_box])
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
end
