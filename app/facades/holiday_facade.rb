class HolidayFacade

  def self.next_three_holidays
    all_holidays = HolidayApiService.holidays
    three_holidays = all_holidays.first(3)
    three_holidays.map do |holiday|
      Holiday.new(holiday)
    end

    # this returns the next three holidays
    # Service.map do |thing|
    #  Poro.new(thing)
    # end
  end
  # def self.next_three_holidays
  #   all_holidays = HolidayApiService.holidays
  #   three_holidays = all_holidays.first(3)
  #   three_holidays.map do |holiday|
  #     holiday.select do |key, value|
  #       key == :date || key == :name
  #     end
  #   end
  #   # this returns the next three holidays
  #   # Service.map do |thing|
  #   #  Poro.new(thing)
  #   # end
  # end
end
