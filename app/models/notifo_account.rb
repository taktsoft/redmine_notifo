class NotifoAccount < ActiveRecord::Base
  unloadable
  belongs_to :user

  def deliver_notification(title, message, url=nil)
    notifo = Notifo::Notifo.new(username, api_key)
    begin
      response = notifo.send_notification(username, message, title, url, "Redmine")
      unless response =~ /response_code.*2201/
        raise response
      end
    rescue Exception => e
      logger.error("Could not send Notifo notification to #{user.try(:name)}: #{e}")
      logger.debug("#{e.backtrace}")
    end
  end
end
