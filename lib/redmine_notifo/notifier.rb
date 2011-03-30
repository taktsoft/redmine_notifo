module RedmineNotifo
  class Notifier
    include ActionController::UrlWriter
    include Redmine::I18n

    def self.default_url_options
      h = Setting.host_name
      h = h.to_s.gsub(%r{\/.*$}, '') unless Redmine::Utils.relative_url_root.blank?
      { :host => h, :protocol => Setting.protocol }
    end

    def self.deliver_issue_add(issue)
      self.new.deliver_issue_add(issue)
    end

    def self.deliver_issue_edit(journal)
      self.new.deliver_issue_edit(journal)
    end

    def deliver_issue_add(issue)
      title = "[#{issue.project.identifier}] #{issue.status.name} ##{issue.id} "
      message = "[#{issue.author.name}] #{issue.subject}"
      url = url_for(:controller => 'issues', :action => 'show', :id => issue)
      deliver_notifications(issue.notifo_recipients, title, message, url)
    end

    def deliver_issue_edit(journal)
      issue = journal.journalized.reload
      author = journal.user

      title = "[#{issue.project.identifier}] #{issue.status.name} ##{issue.id} "
      message = "[#{author.name}] #{issue.subject}"
      url = url_for(:controller => 'issues', :action => 'show', :id => issue)
      deliver_notifications(issue.notifo_recipients, title, message, url)
    end

    protected
    def deliver_notifications(accounts, title, message, url=nil)
      Rails.logger.info("notifo: #{title} #{message} #{url}")
      Rails.logger.info("notifo to: #{accounts.inspect}")
      accounts.each do |notifo_account|
        notifo_account.deliver_notification(title, message, url)
      end
    end
  end
end
