# frozen_string_literal: true

class ArticleImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*_args)
    ActionController::Base.helpers.asset_path('default-news-image.jpg')
  end

  version :thumb do
    process resize_to_fit: [250, 250]
  end

  version :little do
    process resize_to_fit: [180, 180]
  end
end
