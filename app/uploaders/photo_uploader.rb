class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def extension_white_list
    %w(jpg jpeg png pdg pdf)
  end

  process :convert => 'jpg'
end
