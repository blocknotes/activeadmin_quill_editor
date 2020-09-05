# frozen_string_literal: true

class Post < ApplicationRecord
  has_many_attached :images

  validates :title, allow_blank: false, presence: true
end
