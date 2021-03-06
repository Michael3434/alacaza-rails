class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  before :cache, :save_original_filename

  version :large do
      # returns an image with a maximum width of 100px
      # while maintaining the aspect ratio
      # 10000 is used to tell CW that the height is free
      # and so that it will hit the 100 px width first
      process :resize_to_fit => [600, 10000]
    end

  version :thumb do
    process resize_to_fill: [200,200]
  end

  def save_original_filename(file)
    unless model.is_a?(User) || model.is_a?(Item)
      model.original_filename ||= file.original_filename if file.respond_to?(:original_filename)
    end
  end

  def extension_white_list
    %w(jpg jpeg png pdg pdf)
  end
end
