# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/home/nayena/src/cphgames/snmp_polling/cron.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


every 1.minutes do
  command "/home/nayena/.nvm/versions/node/v5.9.0/bin/node /home/nayena/src/cphgames/snmp_polling/polling.js"
  command "/home/nayena/.nvm/versions/node/v5.9.0/bin/node /home/nayena/src/cphgames/snmp_polling/polling_non64.js"
  command "/home/nayena/.nvm/versions/node/v5.9.0/bin/node /home/nayena/src/cphgames/snmp_polling/heartbeat.js"
end

