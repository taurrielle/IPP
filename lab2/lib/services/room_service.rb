class Services::RoomService
  attr_reader :data, :kitchen

  def initialize(data)
    @data = data
  end

  def execute
    cook_task = Services::Tasks::CookTask.new(@data.room, @data.order)
    cook_task.execute_task
    delivery_task = Services::Tasks::DeliveryTask.new(@data.room, @data.order)
    delivery_task.execute_task
    puts "Order done in #{cook_task.get_time_required + delivery_task.get_time_required} minutes"
    @data.update_attributes(status: "DONE")
  end
end