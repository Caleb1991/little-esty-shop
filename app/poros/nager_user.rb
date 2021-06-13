class NagerUser
  attr_reader :holiday_data

  def initialize(country)
    @holiday_data = NagerAPI.holiday_info(country)
  end

  def next_three_holidays
    holidays = []

    holidays << @holiday_data[0][:localName] + ' ' + @holiday_data[0][:date]

    holidays << @holiday_data[1][:localName] + ' ' + @holiday_data[1][:date]

    holidays << @holiday_data[2][:localName] + ' ' + @holiday_data[2][:date]

    holidays
  end
end
