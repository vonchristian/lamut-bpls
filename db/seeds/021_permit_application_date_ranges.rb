BploSection::Settings::PermitApplicationDateRange.find_or_create_by(start_date: Time.zone.now.beginning_of_year, end_date: Time.zone.now.beginning_of_year + 19.days)
