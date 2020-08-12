class Post < ApplicationRecord
  has_rich_text :description
  has_one_attached :image

  enum category: [ :education, :business, :teaching ]

  scope :upload_attachments, -> { with_rich_text_description.with_attached_image }

  validates :title, presence: true, length: { maximum: 25 }
  validates :description, presence: true
end
