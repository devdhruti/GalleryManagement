ActiveAdmin.register User do
  config.sort_order = 'id_asc'
  permit_params :id, :email, :created_at, :updated_at, :confirmed_at, :confirmation_token, :confirmation_sent_at
  filter :email

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :updated_at
    column :confirmation_token
    column :confirmed_at
    column :confirmation_sent_at
    actions
  end
  form do |f|
    f.inputs do
      f.input :id
      f.input :email
      f.input :created_at
      f.input :updated_at
      f.input :confirmation_token
      f.input :confirmed_at
      f.input :confirmation_sent_at
    end
    f.actions
  end

end
