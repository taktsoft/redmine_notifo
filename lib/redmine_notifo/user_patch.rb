module RedmineNotifo
  # Patches Redmine's Users dynamically.  Adds a relation to notifo_account.
  module UserPatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      # Same as typing in the class 
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        has_one :notifo_account
        accepts_nested_attributes_for :notifo_account
        safe_attributes 'notifo_account'
        safe_attributes 'notifo_account_attributes'
      end

    end

    module ClassMethods
    end

    module InstanceMethods
    end
  end
end

