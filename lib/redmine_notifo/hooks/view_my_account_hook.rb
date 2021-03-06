module RedmineNotifo
  module Hooks
    class ViewMyAccountHook < Redmine::Hook::ViewListener
      render_on(:view_my_account, :partial => 'notifo_settings/settings', :layout => false)
      render_on(:view_users_form, :partial => 'notifo_settings/settings', :layout => false)
    end
  end
end
