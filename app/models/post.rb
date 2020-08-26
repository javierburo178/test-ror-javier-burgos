class Post < ApplicationRecord
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  has_rich_text :description
  enum category: [ :education, :business, :teaching ]
  scope :upload_attachments, -> { with_rich_text_description.with_attached_image }
  validates :title, presence: true, length: { maximum: 25 }
  validates :description, presence: true
  has_one_attached :image
  after_update  :check_cropping
  def check_cropping
    self.crop_settings = {x: crop_x, y: crop_y, w: crop_w, h: crop_h} if cropping?
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def cropped_image
    if image.attached?
      if crop_settings.is_a? Hash
        dimensions = "#{crop_settings['w']}x#{crop_settings['h']}"
        coord = "#{crop_settings['x']}+#{crop_settings['y']}"
        image.variant(
            crop: "#{dimensions}+#{coord}"
        ).processed
      else
        image
      end
    end
  end


  def thumbnail(size = '100x100')
    if  image.attached?
      if crop_settings.is_a? Hash
        dimensions = "#{crop_settings['w']}x#{crop_settings['h']}"
        coord = "#{crop_settings['x']}+#{crop_settings['y']}"
        image.variant(
            crop: "#{dimensions}+#{coord}",
            resize: size
        ).processed
      else
        image.variant(resize: size).processed
      end
    end
  end
end
