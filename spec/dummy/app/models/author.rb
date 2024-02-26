# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :posts
  has_many :published_posts, -> { published }, class_name: 'Post'
  has_many :recent_posts, -> { recents }, class_name: 'Post'

  has_many :tags, through: :posts

  has_one :profile, inverse_of: :author, dependent: :destroy

  has_one_attached :avatar

  accepts_nested_attributes_for :profile, allow_destroy: true
  accepts_nested_attributes_for :posts, allow_destroy: true

  validates :email, format: { with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\z/i, message: 'Invalid email' }

  validate -> {
    errors.add( :base, 'Invalid age' ) if !age || age.to_i % 3 == 1
  }

  def to_s
    "#{name} (#{age})"
  end

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[age created_at email id name updated_at]
    end
  end
end
