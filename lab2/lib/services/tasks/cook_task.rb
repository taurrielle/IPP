class Services::Tasks::CookTask < Services::Tasks::BaseTask
  def initialize(room, order)
    super('Cook food', room, order)
  end

  def get_time_required
    10
  end
end
