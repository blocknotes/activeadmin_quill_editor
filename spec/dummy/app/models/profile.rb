# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :author, inverse_of: :profile, touch: true

  def to_s
    description
  end
end
