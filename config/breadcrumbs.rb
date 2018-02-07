crumb :root do
  link "Home", treasury_department_index_path
end
crumb :settings do
  link "Settings", bplo_section_settings_path
end
crumb :new_employee do
  link 'New Employee', bplo_section_settings_path
  parent :settings
end

crumb :edit_employee do |user|
  link 'Update Password', user
  parent :user, user
end

# Issue
crumb :user do |user|
  link user.first_name, user
  parent :settings
end
crumb :reports do
  link "Reports", reports_path
end
crumb :special_permits do
  link "Special Permits", special_permits_path
end

crumb :special_permit do |special_permit|
  link special_permit.name, special_permit_path(special_permit)
  parent :special_permits
end
crumb :new_special_permit_assessment do |special_permit|
  link "New Assessment", special_permit_path(special_permit)
  parent :special_permit, special_permit
end
crumb :businesses do
  link "Businesses", businesses_path
end
crumb :business do |business|
  link business.name, business
  parent :businesses
end
crumb :edit_business do |business|
  link "Edit Business Info", business
  parent :business, business
end
crumb :business_business_activities do |business|
  link "Add Business Activities", business_path(business)
  parent :business, business
end
crumb :business_business_fees do |business|
  link "Add Additional Fees", business_path(business)
  parent :business, business
end
crumb :new_business_assessment do |business|
  link "New Assessment", business_path(business)
  parent :business, business
end
crumb :taxpayers do
  link "Taxpayers", taxpayers_path
end
crumb :taxpayer do |taxpayer|
  link taxpayer.full_name, taxpayer_path(taxpayer)
  parent :taxpayers
end
crumb :new_taxpayer_business do |taxpayer|
  link "New Business", taxpayer_path(taxpayer)
  parent :taxpayer, taxpayer
end
crumb :business_permits do
  link "Business Permits", business_permits_path
end
crumb :monitoring do
  link "Monitoring", monitoring_index_path
end
crumb :new_business_zoning_fee do |business|
  link "Add Zoning Fee", business_path(business)
  parent :business, business
end
crumb :new_business_annual_inspection_fee do |business|
  link "Add Annual Inspection Fee", business_path(business)
  parent :business, business
end
crumb :new_business_documentary_stamp_fee do |business|
  link "Add Documentary Stamp Fee", business_path(business)
  parent :business, business
end
crumb :new_business_sealing_fee do |business|
  link "Add Sealing Fee", business_path(business)
  parent :business, business
end
crumb :new_business_occupancy_permit_fee do |business|
  link "Add Occupancy Permit Fee", business_path(business)
  parent :business, business
end
crumb :new_business_building_permit_fee do |business|
  link "Add Building Permit Fee", business_path(business)
  parent :business, business
end

crumb :new_business_electrical_installation_fee do |business|
  link "Asess Electrical Installation Fee", business_path(business)
  parent :business, business
end

crumb :new_business_plumbing_installation_fee do |business|
  link "Asess Plumbing Installation Fee", business_path(business)
  parent :business, business
end
crumb :new_business_surcharge do |business|
  link "Asess Surcharges", business_path(business)
  parent :business, business
end
crumb :new_business_late_registration_interest do |business|
  link "Asess Interests", business_path(business)
  parent :business, business
end
crumb :new_business_other_accessories_fee do |business|
  link "Asess Other Accessories Fee", business_path(business)
  parent :business, business
end

crumb :new_business_engineering_penalty do |business|
  link "Asess Engineering Penalty/Surcharge Fee", business_path(business)
  parent :business, business
end

crumb :tricycles do
  link "Tricycles", tricycles_path
end

crumb :tricycle do |tricycle|
  link tricycle.mtop_number, tricycle
  parent :tricycles
end
crumb :new_tricycle_fare_adjustment_fee do |tricycle|
  link tricycle.mtop_number, tricycle
  parent :tricycle, tricycle
end

crumb :add_tricycle_fee do |tricycle|
  link tricycle.mtop_number, tricycle
  parent :tricycle, tricycle
end
crumb :new_tricycle_assessment do |tricycle|
  link "New Tricycle Assessment", tricycle
  parent :tricycle, tricycle
end

crumb :treasury_department_businesses do
  link "Businesses", treasury_department_businesses_path
end

crumb :treasury_department_collections do
  link "Collections", treasury_department_collections_path
end

crumb :treasury_department_business do |business|
  link business.name, treasury_department_business_path(business)
  parent :treasury_department_businesses
end

crumb :fire_department_businesses do
  link "Businesses", fire_department_businesses_path
end

crumb :fire_department_collections do
  link "Collections", fire_department_collections_path
end

crumb :fire_department_business do |business|
  link business.name, fire_department_business_path(business)
  parent :fire_department_businesses
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
