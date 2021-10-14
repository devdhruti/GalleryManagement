ActiveAdmin.register AdminUser do
  config.sort_order = 'id_asc'
  permit_params :email, :password, :password_confirmation
  filter :email

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
