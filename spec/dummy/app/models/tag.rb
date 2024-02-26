# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :post_tags, inverse_of: :tag, dependent: :destroy
  has_many :posts, through: :post_tags

  class << self
    def ransackable_associations(auth_object = nil)
      %w[post_tags posts]
    end

    def ransackable_attributes(auth_object = nil)
      %w[created_at id id_value name updated_at]
    end
  end
end
