# frozen_string_literal: true

class CreatePostTags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_tags do |t|
      t.belongs_to :post, foreign_key: true
      t.belongs_to :tag, foreign_key: true

      t.timestamps
    end
  end
end
