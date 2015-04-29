class Scaler < ActiveRecord::Base
  attr_accessor :image_dimensions, :bounding_box
  validate :even_number_of_image_dimensions, :two_bounding_box_dimensions

  def initialize(image_dimensions, bounding_box)
    @image_dimensions = image_dimensions
    @bounding_box = bounding_box
  end

  def parse_image_dimensions
    image_dimensions = image_dimensions[1..-2].split(",").map {|dim| dim.to_i}
  end

  def parse_bounding_box
    bounding_box = bounding_box[1..-2].split(",").map {|dim| dim.to_i}
  end

  def even_number_of_image_dimensions
    image_dimensions.length % 2 == 0
  end

  def two_bounding_box_dimensions
    bounding_box.length == 2
  end
end
