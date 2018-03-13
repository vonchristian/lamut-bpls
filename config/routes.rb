Rails.application.routes.draw do

  unauthenticated :user do
    root :to => 'home#index', :constraints => lambda { |request| request.env['warden'].user.nil? }, as: :unauthenticated_root
  end
  root :to => 'fire_department#index', :constraints => lambda { |request| request.env['warden'].user.role == 'fire_safety_officer' if request.env['warden'].user }, as: :fire_department_root
   root :to => 'treasury_department#index', :constraints => lambda { |request| request.env['warden'].user.role == 'collection_officer' if request.env['warden'].user }, as: :treasury_department_root
resources :search_results, only: [:index]
root :to => 'businesses#index', :constraints => lambda { |request| request.env['warden'].user.role == 'bplo_officer' if request.env['warden'].user }, as: :bplo_department_root
root :to => 'businesses#index', :constraints => lambda { |request| request.env['warden'].user.role == 'engineering_officer' if request.env['warden'].user }, as: :engineering_department_root
root :to => 'businesses#index', :constraints => lambda { |request| request.env['warden'].user.role == 'zoning_officer' if request.env['warden'].user }, as: :zoning_department_root
root :to => 'businesses#index', :constraints => lambda { |request| request.env['warden'].user.role == 'system_administrator' if request.env['warden'].user }, as: :admin_department_root
root :to => 'businesses#index', :constraints => lambda { |request| request.env['warden'].user.role == 'mayors_office_staff' if request.env['warden'].user }, as: :mayor_department_root

  devise_for :users, controllers: { sessions: 'users/sessions' , registrations: "bplo_section/settings/users"}
  resources :users, only: [:show, :edit, :update]
  resources :reports, only: [:index]
  namespace :reports do
    resources :bir, only: [:index]
    resources :gcf, only: [:index]
    resources :dilg, only: [:index]
    resources :cmci, only: [:index]
    resources :dti, only: [:index]
    resources :bfp, only: [:index]
    resources :philhealth, only: [:index]
    resources :sss, only: [:index]
  end

  resources :competetive_index_categories, only: [:show]
  resources :collections, only: [:index, :show, :destroy]
  resources :business_requirement_verifications, only: [:create]
  resources :business_permits, only: [:index, :show]
  resources :business_activities, only: [:destroy], module: :businesses
  resources :business_fees, only: [:destroy], module: :businesses
  resources :dashboard, only: [:index]
  resources :taxpayers do
    resources :taxpayer_businesses, only: [:new, :create], module: :taxpayers
  end
  resources :businesses, only: [:index, :show, :destroy] do
    resources :info, only: [:index], module: :businesses
    resources :checklist, only: [:index], module: :businesses
    resources :settings, only: [:index], module: :businesses
    resources :business_permits, only: [:index], module: :businesses
    resources :bir_registrations, only: [:new, :create], module: :businesses
    resources :dti_registrations, only: [:new, :create], module: :businesses
    resources :sec_registrations, only: [:new, :create], module: :businesses
    resources :cda_registrations, only: [:new, :create], module: :businesses

    resources :business_tax_payments, only: [:new, :create], module: :businesses
    resources :payments, only: [:new, :create], module: :businesses

    resources :assessments, only: [:index, :new, :create], module: :businesses
    resources :additional_assessments, only: [:new, :create], module: :businesses
    resources :revocations, only: [:new, :create], module: :businesses
    resources :late_registration_interests, only: [:create], module: :businesses
    resources :fire_safety_inspection_fee_collections, only: [:new, :create], module: :businesses

  end
  resources :departments, only: [:index, :new, :create]
  resources :business_registrations, only: [:new, :create]
  resources :business_permit_applications, shallow: true do
    resources :permit_approvals, only: [:new, :create]
  end

  namespace :bplo_section do
    resources :line_of_businesses, only: [:show]
    resources :taxpayers, only: [:show] do
      resources :businesses, only: [:new, :create]
      resources :tricycles, only: [:new, :create]
    end

    resources :businesses, only: [:show, :edit, :update] do
      resources :line_of_business_selections, only: [:new, :create], module: :businesses
      resources :business_permit_applications, only: [:new, :create], module: :businesses
      resources :business_activities, only: [:index, :new, :create]
      resources :cockpit_details, only: [:index, :new, :create]
      resources :gross_sales, only: [:new, :create, :edit, :update], module: :businesses
      resources :business_requirements, only: [:new, :create]
      resources :business_fees, only: [:new, :create]
      resources :gross_sales_tax_configs, only: [:edit, :update], module: :configurations
      resources :building_permit_fees, only: [:new, :create], module: :businesses
      resources :electrical_installation_fees, only: [:new, :create], module: :businesses
      resources :plumbing_installation_fees, only: [:new, :create], module: :businesses
      resources :other_accessories_fees, only: [:new, :create], module: :businesses
      resources :engineering_penalties, only: [:new, :create], module: :businesses
      resources :surcharges, only: [:new, :create], module: :businesses
      resources :late_registration_interests, only: [:new, :create], module: :businesses


      resources :zoning_fees, only: [:new, :create], module: :businesses
      resources :annual_inspection_fees, only: [:new, :create], module: :businesses
      resources :occupancy_permit_fees, only: [:new, :create], module: :businesses
      resources :documentary_stamp_fees, only: [:new, :create, :edit], module: :businesses
      resources :sealing_fees, only: [:new, :create], module: :businesses

    end
    resources :business_activities, only: [:show] do
      resources :gross_sales, only: [:new, :create]
    end



    resources :gross_sales_tax_business_categories, only: [:show] do
      resources :gross_sales_taxes, only: [:new, :create], module: :taxes
    end
    resources :business_requirements, only: [:destroy]


    namespace :configs do
      resources :fire_safety_inspection_fee_configs, only: [:new, :create]
    end

    namespace :taxes do
      resources :capital_taxes, only: [:new, :create]
    end
    resources :settings, only: [:index]
    namespace :settings do
      resources :public_markets, only: [:new, :create]
      resources :ownership_types, only: [:new, :create, :edit, :update]
      resources :mode_of_payments, only: [:new, :create, :edit, :update]
      resources :barangays, only: [:new, :create, :edit, :update]
      resources :line_of_businesses, only: [:index, :new, :create, :edit, :update, :show]
      resources :fees, only: [:new, :create, :edit, :update]
      resources :taxes, only: [:new, :create, :edit, :update]
      resources :cockpit_personnel_fees, only: [:new, :create, :edit, :update]

      resources :late_payment_surcharges, only: [:new, :create]
      resources :interest_rates, only: [:new, :create]
      resources :required_documents, only: [:new, :create, :edit, :update]
      resources :departments, only: [:new, :create]
      resources :gross_sales_tax_business_categories, only: [:new, :create]
      resources :users, only: [:new, :create, :show]
      resources :signatories, only: [:new, :create]
      resources :permit_application_date_ranges, only: [:new, :create]
      resources :tricycle_fees, only: [:new, :create, :edit, :update]
      resources :tricycle_requirements, only: [:new, :create, :edit, :update]
      resources :tricycle_organizations, only: [:new, :create, :edit, :update]
    end
  end
  resources :business_requirements, shallow: true do
    resources :verifications, only: [:new, :create], module: [:businesses, :business_requirements]
    resources :issuances, only: [:new, :create], module: [:businesses, :business_requirements]
  end
  namespace :fees_settings do
    resources :sanitary_inspection_fees, only: [:new, :create]
    resources :storage_permit_fees, only: [:new, :create]
  end
  resources :monitoring, only: [:index]
  namespace :monitoring do
    resources :closed_businesses, only: [:index]

    resources :unrenewed_businesses, only: [:index]
    resources :barangays, only: [:show] do
      match "/registered_businesses" => "registered_businesses#index",  via: [:get], on: :collection
      match "/unrenewed_businesses" => "unrenewed_businesses#index",  via: [:get], on: :collection
    end
  end
  resources :bir_registrations, only: [:edit, :update], module: :registrations
  resources :dti_registrations, only: [:edit, :update], module: :registrations
  resources :sec_registrations, only: [:edit, :update], module: :registrations
  resources :cda_registrations, only: [:edit, :update], module: :registrations
  namespace :public_market do
    resources :transient_tenants, only: [:index]
    resources :regular_tenants, only: [:index]
  end
  resources :tricycles do
    resources :applicable_tricycle_fees, only: [:new, :create], module: :tricycles
    resources :fare_adjustment_fees, only: [:new, :create], module: :tricycles
    resources :late_registration_interests, only: [:new, :create], module: :tricycles
    resources :surcharges, only: [:new, :create], module: :tricycles
    resources :tricycle_requirements, only: [:new, :create]
    resources :assessments, only: [:new, :create], module: :tricycles
    resources :payments, only: [:new, :create], module: :tricycles
    resources :tricycle_permit_applications, only: [:new, :create], module: :tricycles
  end

  resources :applicable_tricycle_fees, only: [:destroy], module: :tricycles
  resources :tricycle_registrations, only: [:new, :create]
  resources :tricycle_permit_applications, shallow: true do
    resources :permit_approvals, only: [:new, :create], module: :tricycles
  end
  resources :tricycle_permits, only: [:index, :show]
  resources :special_permits, only: [:index, :show] do
    resources :assessments, only: [:new, :create], module: :special_permits
    resources :payments, only: [:new, :create], module: :special_permits
  end
  resources :special_permit_applications, only: [:new, :create]
  resources :registered_business_reports, only: [:index]
  resources :unregistered_business_reports, only: [:index]
  resources :retired_business_reports, only: [:index]
  resources :owned_by_women_business_reports, only: [:index]
  resources :business_reports, only: [:index]
  resources :temporary_business_permits, only: [:index, :show]

  resources :assessments, only: [:index] do
    resources :payments, only: [:new, :create], module: :assessments
  end

  resources :treasury_department, only: [:index]
  namespace :treasury_department do
    resources :businesses, only: [:index, :show]
    resources :barangays, only: [:index, :show]
    resources :collections, only: [:index, :show, :edit, :update]
    resources :assessments, only: [:index] do
      resources :payments, only: [:new, :create], module: :assessments
    end
  end

  namespace :fire_department do
    resources :businesses, only: [:index, :show]
    resources :barangays, only: [:index, :show]
    resources :payments, shallow: true do
      resources :percentage_collections, only: [:new, :create]
    end
    resources :collections, only: [:index, :show, :edit, :update]
  end

  resources :tricycle_reports, only: [:index]
  resources :tricycle_organizations, only: [:show]
  resources :documentary_stamp_fees, only: [:edit, :update], module: :fees
  resources :analytics, only: [:index]
  resources :sealing_fees, only: [:edit, :update]
  resources :engineering_penalties, only: [:edit, :update]
  resources :occupancy_permit_fees, only: [:edit, :update]
  resources :annual_inspection_fees, only: [:edit, :update]
  resources :electrical_installation_fees, only: [:edit, :update]
  resources :plumbing_installation_fees, only: [:edit, :update]
  resources :other_accessories_fees, only: [:edit, :update]
  resources :building_permit_fees, only: [:edit, :update]
  resources :zoning_fees, only: [:edit, :update]
  resources :addresses, only: [:edit, :update]
  resources :gross_sales, only: [:edit, :update]

end
