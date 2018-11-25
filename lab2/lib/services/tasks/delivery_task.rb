class Services::Tasks::DeliveryTask < Services::Tasks::BaseTask
  def initialize(room, order)
    super('Deliver food', room, order)
  end

  def get_time_required
    5
  end
end
