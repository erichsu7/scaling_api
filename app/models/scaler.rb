class Scaler < ActiveRecord::Base
  attr_accessor :image_dimensions, :bounding_box

  def initialize(image_dimensions, bounding_box)
    @image_dimensions = image_dimensions
    @bounding_bo = bounding_box
  end
end
