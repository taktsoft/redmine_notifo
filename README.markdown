Redmine Notifo
==============

Plugin which integrates Notifo push notifications with Redmine. When an issue is created or updated you will receive push notifications.

## Prerequisite

A Notifo account is required. Visit http://notifo.com to get one.

This plugin depends on httparty. To install run

    $ gem install httparty

## Installation

Download the sources and put them to your vendor/plugins folder.

    $ cd {REDMINE_ROOT}
    $ git clone git://github.com/taktsoft/redmine_notifo.git vendor/plugins/redmine_notifo

Migrate database.

    $ rake db:migrate_plugins RAILS_ENV:production

Users should now be able to configure their Notifo credentials in their account settings. All changes which provoke email notifications now also create Notifo notifications.

## Translations

- en by Daniel Lehmann
- de by Daniel Lehmann

## ToDO

- Error Handling
- Async / Background calls to notifo
- Support for notifications on wiki changes etc.

## Changelog

### 0.1.0

- Initial release
