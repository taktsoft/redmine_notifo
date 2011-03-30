class NotifoJournalObserver < ActiveRecord::Observer
  unloadable
  observe :journal

  def after_create(journal)
    if Setting.notified_events.include?('issue_updated') ||
        (Setting.notified_events.include?('issue_note_added') && journal.notes.present?) ||
        (Setting.notified_events.include?('issue_status_updated') && journal.new_status.present?) ||
        (Setting.notified_events.include?('issue_priority_updated') && journal.new_value_for('priority_id').present?)
      RedmineNotifo::Notifier.deliver_issue_edit(journal)
    end
  end
end
