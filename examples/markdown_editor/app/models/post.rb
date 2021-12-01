# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, allow_blank: false, presence: true
end
