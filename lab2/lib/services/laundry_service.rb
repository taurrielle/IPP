class Services::LaundryService
  attr_reader :data, :cleaning_dpt

  def initialize(data)
    @data = data
  end

  def execute
    sleep 2               #laundrying
    @data.update_attributes(status: "DONE")
  end
end