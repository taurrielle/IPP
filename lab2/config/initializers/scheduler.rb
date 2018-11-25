require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

scheduler.every '20s' do
  ConciergeWorker.instance.act_on_requests
end