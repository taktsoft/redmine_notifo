module RedmineNotifo
  # Patches Redmine's Issues dynamically.
  module IssuePatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      # Same as typing in the class 
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      # Returns the notifo accounts of users (including watchers) that should be notified
      def notifo_recipients
        notified_users = project.notified_users
        notified_users += watcher_users.active.reject {|user| user.mail_notification == 'none'}
        # Author and assignee are always notified unless they have been
        # locked or don't want to be notified
        notified_users << author if author && author.active? && author.notify_about?(self)
        notified_users << assigned_to if assigned_to && assigned_to.active? && assigned_to.notify_about?(self)
        notified_users.uniq!
        # Remove users that can not view the issue
        notified_users.reject! {|user| !visible?(user)}
        notifo_accounts = notified_users.collect do |user|
          user.notifo_account if user.notifo_account && user.notifo_account.active
        end
        notifo_accounts.compact!
        return notifo_accounts
      end
    end
  end
end

