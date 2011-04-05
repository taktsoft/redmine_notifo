require 'redmine'
require 'httparty'

require_dependency 'principal'
require_dependency 'user'
require_dependency 'issue'
require_dependency 'redmine_notifo/hooks/view_my_account_hook'
require_dependency 'notifo/notifo'

require 'dispatcher'

Dispatcher.to_prepare :redmine_notifo do
  require_dependency 'principal'
  require_dependency 'user'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless User.included_modules.include? RedmineNotifo::UserPatch
    User.send(:include, RedmineNotifo::UserPatch)
  end

  require_dependency 'issue'
  unless Issue.included_modules.include? RedmineNotifo::IssuePatch
    Issue.send(:include, RedmineNotifo::IssuePatch)
  end

  ActiveRecord::Base.observers += [:notifo_journal_observer, :notifo_issue_observer]
end

Redmine::Plugin.register :redmine_notifo do
  name 'Redmine Notifo plugin'
  author 'Daniel Lehmann'
  description 'Send notifo updates'
  version '0.1.0'
  url 'http://github.com/taktsoft/redmine_notifo'
  author_url 'http://www.taktsoft.com'

  requires_redmine :version_or_higher => '1.0.0'
end
