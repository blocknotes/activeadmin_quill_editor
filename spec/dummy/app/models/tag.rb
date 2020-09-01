# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :post_tags, inverse_of: :tag, dependent: :destroy
  has_many :posts, through: :post_tags
end
