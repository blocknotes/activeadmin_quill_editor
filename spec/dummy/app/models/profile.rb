# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :author, inverse_of: :profile, touch: true

  def to_s
    description
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[author_id created_at description id updated_at]
  end
end
