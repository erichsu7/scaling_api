class Scaler
  include ActiveModel::Validations

  attr_accessor :image_dimensions, :bounding_box
  
  validate :even_number_of_image_dimensions,
            :image_dimensions_are_integers,
            :two_bounding_box_dimensions,
            :bounding_box_dimensions_are_integers

  def initialize(image_dimensions, bounding_box)
    @image_dimensions = image_dimensions
    @bounding_box = bounding_box
  end

  def parse_image_dimensions
    self.image_dimensions = self.image_dimensions[1..-2].split(",").map do |dim|
      # A non-integer is converted to 0. Check if the conversion back to string
      # still equals the original dimension to see if it's not an integer.
      dim.to_i unless dim.to_i.to_s != dim
    end
  end

  def parse_bounding_box
    self.bounding_box = self.bounding_box[1..-2].split(",").map do |dim|
      dim.to_i unless dim.to_i.to_s != dim
    end
  end

  def scale_dimensions
    i = 0
    while i < image_dimensions.length
      x_scalar = bounding_box[0].to_f / image_dimensions[i]
      y_scalar = bounding_box[1].to_f / image_dimensions[i + 1]

      #Scale down using smaller scalar
      if x_scalar < y_scalar
        image_dimensions[i] = (image_dimensions[i] * x_scalar).to_i
        image_dimensions[i + 1] = (image_dimensions[i + 1] * x_scalar).to_i
      else
        image_dimensions[i] = (image_dimensions[i] * y_scalar).to_i
        image_dimensions[i + 1] = (image_dimensions[i + 1] * y_scalar).to_i
      end

      i += 2
    end
  end

  private

    def even_number_of_image_dimensions
      unless image_dimensions.length % 2 == 0
        errors.add(:image_dimensions, "must have even number of dimensions")
      end
    end

    def image_dimensions_are_integers
      unless image_dimensions.all? { |dim| dim.is_a?(Integer) }
        errors.add(:image_dimensions, "must all be integers")
      end
    end

    def two_bounding_box_dimensions
      unless bounding_box.length == 2
        errors.add(:bounding_box, "must have two dimensions")
      end
    end

    def bounding_box_dimensions_are_integers
      unless bounding_box.all? { |dim| dim.is_a?(Integer) }
        errors.add(:bounding_box, "dimensions must all be integers")
      end
    end
end
