class NotifoAccount < ActiveRecord::Base
  unloadable
  belongs_to :user
end
