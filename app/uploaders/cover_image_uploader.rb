# encoding: utf-8

class CoverImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :aws
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  # #   # For Rails 3.1+ asset pipeline compatibility:
  #   ActionController::Base.helpers.asset_path([version_name, "sais_thumb.jpg"].compact.join('_'))
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [100, 100]
  end

  version :tile_small do
    process resize_to_fit: [240, 200]
  end

  version :tile_tall do
    process resize_to_fit: [240, 420]
  end

  version :tile_wide do
    process resize_to_fit: [420, 240]
  end

  version :tile_large do
    process resize_to_fit: [500, 420]
  end

  version :cover do
    process resize_to_fit: [1920, 1080]
  end

  version :facebook do
    process resize_to_fit: [600, 315]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
