# frozen_string_literal: true

ActiveAdmin.register Author do
  menu priority: 1

  permit_params :name, :email, :age, :avatar, profile_attributes: %i[id description _destroy]

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :created_at
    actions
  end

  filter :name
  filter :created_at

  show do
    attributes_table do
      row :name
      row :email
      row :age
      row :avatar do |record|
        image_tag url_for(record.avatar), style: 'max-width:800px;max-height:500px' if record.avatar.attached?
      end
      row :created_at
      row :updated_at
      row :profile
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :age
      f.input :avatar,
              as: :file,
              hint: (object.avatar.attached? ? "Current: #{object.avatar.filename}" : nil)
    end
    f.has_many :profile, allow_destroy: true do |ff|
      ff.input :description
    end
    f.actions
  end
end
