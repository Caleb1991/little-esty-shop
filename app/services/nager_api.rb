class NagerAPI

  def self.holiday_info(country)
    response = Faraday.get "https://date.nager.at/api/v3/NextPublicHolidays/#{country}"
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end
end
