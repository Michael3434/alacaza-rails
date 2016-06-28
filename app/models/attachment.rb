class Attachment < ActiveRecord::Base
  class Attachment < ActiveRecord::Base
    CONTENT_TYPES = [
      "application/pdf", # .pdf
      "application/msword", # .doc
      "application/rtf", # .rtf
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document", # .docx
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", # .xlsx
      "application/vnd.openxmlformats-officedocument.presentationml.presentation", # .pptx
      "image/jpeg", # .jpg, .jpeg
      "application/vnd.ms-powerpoint", # .ppt
      "application/vnd.ms-excel" # xls
    ]

    belongs_to :attachable, polymorphic: true

    validates_attachment_presence :document
    validates_attachment_content_type :document, content_type: CONTENT_TYPES
    validates_attachment_size :document, :less_than => 10.megabytes, :message => "dépasse les 10 Mo autorisés."

    def self.images
      where(document_content_type: ["image/jpeg", "image/png"])
    end

    def document_name
      document_file_name.gsub("_", " ")
    end
  end

end
