ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content do
    panel "Recent Users" do
      table_for User.order("created_at desc").limit(5) do
        column :email do |user|
          link_to user.email, admin_user_path(user)
        end
        column :created_at
      end
      strong (link_to "Show All Users" , admin_users_path )
    end
  end
end
