class NotifoIssueObserver < ActiveRecord::Observer
  unloadable
  observe :issue

  def after_create(issue)
    RedmineNotifo::Notifier.deliver_issue_add(issue) if Setting.notified_events.include?('issue_added')
  end
end
