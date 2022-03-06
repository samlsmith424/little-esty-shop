class HolidayApiService
  class << self # everything inside block will be class method

    def holidays
      response = Faraday.new("https://date.nager.at/api/v3/NextPublicHolidays/US").get
      parsed = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
