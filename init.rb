require 'redmine'

require_dependency 'principal'
require_dependency 'user'
require_dependency 'redmine_notifo/hooks/view_my_account_hook'

require 'dispatcher'

Dispatcher.to_prepare :redmine_notifo do
  require_dependency 'principal'
  require_dependency 'user'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless User.included_modules.include? RedmineNotifo::UserPatch
    User.send(:include, RedmineNotifo::UserPatch)
  end
end

Redmine::Plugin.register :redmine_notifo do
  name 'Redmine Notifo plugin'
  author 'Daniel Lehmann'
  description 'Send notifo updates'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
