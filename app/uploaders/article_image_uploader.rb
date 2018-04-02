# frozen_string_literal: true

class ArticleImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    include Cloudinary::CarrierWave

  else
    include CarrierWave::RMagick

    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  def default_url
    ActionController::Base.helpers.asset_path('default-news-image.jpg')
  end

  version :full_size do
    process resize_to_fit: [350, 400]
  end

  version :small_image do
    process resize_to_fit: [100, 100]
  end

  version :small_picture do
    process resize_to_fit: [50, 50]
  end
end
