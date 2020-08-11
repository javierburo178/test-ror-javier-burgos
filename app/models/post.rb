class Post < ApplicationRecord
  has_rich_text :description
  has_one_attached :image
end
