# frozen_string_literal: true

class Post < ApplicationRecord
  # enum state: %i[available unavailable arriving]

  belongs_to :author, inverse_of: :posts, autosave: true

  has_one :author_profile, through: :author, source: :profile

  has_many :post_tags, inverse_of: :post, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many_attached :images

  accepts_nested_attributes_for :post_tags, allow_destroy: true

  validates :title, allow_blank: false, presence: true

  scope :published, -> { where(published: true) }
  scope :recents, -> { where('created_at > ?', Date.today - 8.month) }

  def short_title
    title.truncate 10
  end

  def upper_title
    title.upcase
  end

  class << self
    def ransackable_attributes(auth_object = nil)
      %w[author_id category created_at description dt id position published summary title updated_at]
    end

    def ransackable_associations(auth_object = nil)
      %w[author author_profile images_attachments images_blobs post_tags tags]
    end
  end
end
