class Services::TripPlanningService
  attr_reader :data, :tripAdvisor

  def initialize(data)
    @data = data
  end

  def execute
    sleep 2               #tripping
    @data.update_attributes(status: "DONE")
  end
end