class Services::Tasks::BaseTask
  attr_reader :name

  def initialize(name, room, order)
    @name = name
    @room = room
    @order = order
  end

  def execute_task
    puts @name + " for room ##{@room}\n"
  end
end