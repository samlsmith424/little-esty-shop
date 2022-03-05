class Holiday
  attr_reader :date, :name

  def initialize(holiday)
    @date = holiday[:date]
    @name = holiday[:name]
  end
end
