require 'singleton'

class ConciergeWorker
  include Singleton
  attr_reader :request_list

  def initialize
    @request_list = []
  end

  def act_on_requests
    return if @request_list.empty?
    @request_list.each do |request|
      request.execute
    end
    @request_list = []
  end
end