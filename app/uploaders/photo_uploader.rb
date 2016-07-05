class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  before :cache, :save_original_filename

  def save_original_filename(file)
    model.original_filename ||= file.original_filename if file.respond_to?(:original_filename)
  end

  def extension_white_list
    %w(jpg jpeg png pdg pdf)
  end
end
