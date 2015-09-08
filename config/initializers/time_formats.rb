Time::DATE_FORMATS[:month_day_year] = "%B %d %Y"

Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }