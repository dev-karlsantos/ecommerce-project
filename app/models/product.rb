class Product < ApplicationRecord
  belongs_to :category, class_name: "Category"
  has_one_attached :image

  after_create :resize_image

  def resize_image
    return unless image.attached?

    # Define the desired width and height
    width = 300
    height = 200

    # Open the image using mini_magick
    mini_magick_image = MiniMagick::Image.read(image.download)

    # Resize the image
    mini_magick_image.resize "#{width}x#{height}"

    # Save the resized image back to Active Storage
    image.attach(io: mini_magick_image.to_io, filename: "resized_#{image.filename}")
  end
end
