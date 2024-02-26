# frozen_string_literal: true

ActiveAdmin.register Profile do
  permit_params :author_id, :description
end
