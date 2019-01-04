# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180914031837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.boolean "contra"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false
    t.index ["code"], name: "index_accounts_on_code", unique: true
    t.index ["name"], name: "index_accounts_on_name", unique: true
    t.index ["type"], name: "index_accounts_on_type"
  end

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "barangay_id"
    t.uuid "municipality_or_city_id"
    t.uuid "province_id"
    t.string "street"
    t.string "addressable_type"
    t.uuid "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
    t.index ["barangay_id"], name: "index_addresses_on_barangay_id"
    t.index ["municipality_or_city_id"], name: "index_addresses_on_municipality_or_city_id"
    t.index ["province_id"], name: "index_addresses_on_province_id"
  end

  create_table "amounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.uuid "account_id"
    t.uuid "entry_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "commercial_document_type"
    t.uuid "commercial_document_id"
    t.integer "amount_type"
    t.index ["account_id"], name: "index_amounts_on_account_id"
    t.index ["amount_type"], name: "index_amounts_on_amount_type"
    t.index ["commercial_document_type", "commercial_document_id"], name: "index_commercial_document_on_amounts"
    t.index ["entry_id"], name: "index_amounts_on_entry_id"
    t.index ["type"], name: "index_amounts_on_type"
  end

  create_table "annual_inspection_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.decimal "amount"
    t.datetime "calendar_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_annual_inspection_fees_on_business_id"
  end

  create_table "applicable_tricycle_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "tricycle_fee_id"
    t.uuid "tricycle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tricycle_fee_id"], name: "index_applicable_tricycle_fees_on_tricycle_fee_id"
    t.index ["tricycle_id"], name: "index_applicable_tricycle_fees_on_tricycle_id"
  end

  create_table "applicable_tricycle_requirements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "tricycle_requirement_id"
    t.uuid "tricycle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tricycle_id"], name: "index_applicable_tricycle_requirements_on_tricycle_id"
    t.index ["tricycle_requirement_id"], name: "index_on_tricycle_requirements_applicable_requirements"
  end

  create_table "barangays", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "municipality_or_city_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.index ["municipality_or_city_id", "name"], name: "index_barangays_on_municipality_or_city_id_and_name", unique: true
    t.index ["municipality_or_city_id"], name: "index_barangays_on_municipality_or_city_id"
  end

  create_table "bir_registrations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.datetime "date_issued"
    t.datetime "expiry_date"
    t.string "registration_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_bir_registrations_on_business_id"
  end

  create_table "building_permit_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount"
    t.uuid "business_id"
    t.datetime "calendar_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_building_permit_fees_on_business_id"
  end

  create_table "business_activities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.uuid "line_of_business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "number_of_unit", default: 1
    t.uuid "storage_permit_fee_id"
    t.decimal "volume"
    t.index ["business_id"], name: "index_business_activities_on_business_id"
    t.index ["line_of_business_id"], name: "index_business_activities_on_line_of_business_id"
    t.index ["slug"], name: "index_business_activities_on_slug", unique: true
    t.index ["storage_permit_fee_id"], name: "index_business_activities_on_storage_permit_fee_id"
  end

  create_table "business_areas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.decimal "area", default: "1.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "rented", default: false
    t.uuid "sanitary_inspection_fee_id"
    t.index ["business_id"], name: "index_business_areas_on_business_id"
    t.index ["sanitary_inspection_fee_id"], name: "index_business_areas_on_sanitary_inspection_fee_id"
  end

  create_table "business_capitals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount"
    t.uuid "business_id"
    t.decimal "tax_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_capitals_on_business_id"
  end

  create_table "business_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.uuid "fee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_fees_on_business_id"
    t.index ["fee_id"], name: "index_business_fees_on_fee_id"
  end

  create_table "business_permit_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.string "application_number"
    t.datetime "application_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transaction_type"
    t.uuid "taxpayer_id"
    t.index ["application_number"], name: "index_business_permit_applications_on_application_number", unique: true
    t.index ["business_id"], name: "index_business_permit_applications_on_business_id"
    t.index ["taxpayer_id"], name: "index_business_permit_applications_on_taxpayer_id"
  end

  create_table "business_permit_approvals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "date_approved"
    t.uuid "business_permit_application_id"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "permit_number"
    t.uuid "approver_id"
    t.index ["approver_id"], name: "index_business_permit_approvals_on_approver_id"
    t.index ["business_permit_application_id"], name: "index_permit_approvals_on_permit_application_id"
    t.index ["permit_number"], name: "index_business_permit_approvals_on_permit_number", unique: true
  end

  create_table "business_permit_conditions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "permit_condition_id"
    t.uuid "business_permit_approval_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_permit_approval_id"], name: "index_business_permit_conditions_on_business_permit_approval_id"
    t.index ["permit_condition_id"], name: "index_business_permit_conditions_on_permit_condition_id"
  end

  create_table "business_requirements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "required_document_id"
    t.uuid "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["business_id"], name: "index_business_requirements_on_business_id"
    t.index ["required_document_id"], name: "index_business_requirements_on_required_document_id"
    t.index ["slug"], name: "index_business_requirements_on_slug", unique: true
  end

  create_table "business_tin_plates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "number"
    t.uuid "business_id"
    t.uuid "business_permit_approval_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_tin_plates_on_business_id"
    t.index ["business_permit_approval_id"], name: "index_business_tin_plates_on_business_permit_approval_id"
  end

  create_table "businesses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.uuid "ownership_type_id"
    t.uuid "mode_of_payment_id"
    t.uuid "lessor_id"
    t.uuid "gross_sales_tax_business_category_id"
    t.boolean "deals_only_with_essential_commodities", default: false
    t.uuid "gross_sales_tax_config_id"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "contact_number"
    t.string "email"
    t.integer "status"
    t.integer "business_type"
    t.boolean "business_tax_exempted", default: false
    t.uuid "public_market_tenant_id"
    t.boolean "public_market_vendor", default: false
    t.boolean "owned_by_women", default: false
    t.boolean "is_transient", default: false
    t.index ["gross_sales_tax_business_category_id"], name: "index_on_gross_tax_business_category"
    t.index ["gross_sales_tax_config_id"], name: "index_businesses_on_gross_sales_tax_config_id"
    t.index ["lessor_id"], name: "index_businesses_on_lessor_id"
    t.index ["mode_of_payment_id"], name: "index_businesses_on_mode_of_payment_id"
    t.index ["ownership_type_id"], name: "index_businesses_on_ownership_type_id"
    t.index ["public_market_tenant_id"], name: "index_businesses_on_public_market_tenant_id"
    t.index ["slug"], name: "index_businesses_on_slug", unique: true
  end

  create_table "capital_taxes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cda_registrations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.datetime "date_issued"
    t.datetime "expiry_date"
    t.string "registration_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_cda_registrations_on_business_id"
  end

  create_table "cockpit_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.integer "promoter_count", default: 0
    t.integer "pit_manager_count", default: 0
    t.integer "referee_count", default: 0
    t.integer "bet_taker_count", default: 0
    t.integer "bet_manager_count", default: 0
    t.integer "gaffer_count", default: 0
    t.integer "cashier_count", default: 0
    t.integer "derby_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_cockpit_details_on_business_id"
  end

  create_table "cockpit_personnel_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competetive_index_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_competetive_index_categories_on_name", unique: true
  end

  create_table "construction_taxes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount", default: "0.0"
    t.uuid "fire_dept_collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fire_dept_collection_id"], name: "index_construction_taxes_on_fire_dept_collection_id"
  end

  create_table "conveyance_clearance_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount", default: "0.0"
    t.uuid "fire_dept_collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fire_dept_collection_id"], name: "index_conveyance_clearance_fees_on_fire_dept_collection_id"
  end

  create_table "departments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_departments_on_name", unique: true
  end

  create_table "documentary_stamp_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.decimal "amount"
    t.datetime "calendar_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_documentary_stamp_fees_on_business_id"
  end

  create_table "dti_registrations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.datetime "date_issued"
    t.datetime "expiry_date"
    t.string "registration_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_dti_registrations_on_business_id"
  end

  create_table "electrical_installation_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.datetime "calendar_year"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_electrical_installation_fees_on_business_id"
  end

  create_table "employee_counts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.integer "number"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_employee_counts_on_business_id"
    t.index ["type"], name: "index_employee_counts_on_type"
  end

  create_table "engineering_penalties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.datetime "calendar_year"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_engineering_penalties_on_business_id"
  end

  create_table "entries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reference_number"
    t.datetime "entry_date"
    t.string "commercial_document_type"
    t.uuid "commercial_document_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.integer "transaction_type"
    t.uuid "barangay_id"
    t.boolean "paid", default: false
    t.index ["barangay_id"], name: "index_entries_on_barangay_id"
    t.index ["commercial_document_type", "commercial_document_id"], name: "index_on_commercial_document_entry"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "essential_commodities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_essential_commodities_on_name", unique: true
  end

  create_table "fare_adjustment_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "tricycle_id"
    t.decimal "amount"
    t.date "calendar_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tricycle_id"], name: "index_fare_adjustment_fees_on_tricycle_id"
  end

  create_table "fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.decimal "amount"
    t.boolean "default_fee", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "debit_account_id"
    t.uuid "credit_account_id"
    t.index ["credit_account_id"], name: "index_fees_on_credit_account_id"
    t.index ["debit_account_id"], name: "index_fees_on_debit_account_id"
    t.index ["name"], name: "index_fees_on_name", unique: true
  end

  create_table "fire_code_fines", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount", default: "0.0"
    t.uuid "fire_dept_collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fire_dept_collection_id"], name: "index_fire_code_fines_on_fire_dept_collection_id"
  end

  create_table "fire_dept_collections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "entry_date"
    t.uuid "entry_id"
    t.uuid "collector_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference_number"
    t.index ["collector_id"], name: "index_fire_dept_collections_on_collector_id"
    t.index ["entry_id"], name: "index_fire_dept_collections_on_entry_id"
  end

  create_table "fire_safety_inspection_fee_collections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "date"
    t.string "reference_number"
    t.uuid "business_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_fire_safety_inspection_fee_collections_on_business_id"
  end

  create_table "fire_safety_inspection_fee_configs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "fee_type"
    t.decimal "amount"
    t.decimal "percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fire_safety_inspection_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount"
    t.datetime "calendar_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "fire_dept_collection_id"
    t.uuid "business_id"
    t.index ["business_id"], name: "index_fire_safety_inspection_fees_on_business_id"
    t.index ["fire_dept_collection_id"], name: "index_fire_safety_inspection_fees_on_fire_dept_collection_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "gross_sales", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_activity_id"
    t.date "calendar_year"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "tax_amount"
    t.uuid "business_id"
    t.index ["business_activity_id"], name: "index_gross_sales_on_business_activity_id"
    t.index ["business_id"], name: "index_gross_sales_on_business_id"
  end

  create_table "gross_sales_tax_business_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["name"], name: "index_gross_sales_tax_business_categories_on_name", unique: true
    t.index ["slug"], name: "index_gross_sales_tax_business_categories_on_slug", unique: true
  end

  create_table "gross_sales_tax_configs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "tax_config", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gross_sales_taxes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "minimum_gross_sale"
    t.decimal "maximum_gross_sale"
    t.decimal "tax_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "gross_sales_tax_business_category_id"
    t.uuid "tax_type_id"
    t.decimal "tax_rate"
    t.decimal "tax_rate_for_excess"
    t.decimal "gross_limit"
    t.decimal "minimum_tax_amount"
    t.index ["gross_sales_tax_business_category_id"], name: "index_gross_sales_taxes_on_gross_sales_tax_business_category_id"
    t.index ["tax_type_id"], name: "index_gross_sales_taxes_on_tax_type_id"
  end

  create_table "installation_clearance_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount", default: "0.0"
    t.uuid "fire_dept_collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fire_dept_collection_id"], name: "index_installation_clearance_fees_on_fire_dept_collection_id"
  end

  create_table "interest_rates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issuances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_requirement_id"
    t.datetime "issue_date"
    t.string "reference_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_requirement_id"], name: "index_issuances_on_business_requirement_id"
  end

  create_table "late_payment_surcharges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "late_registration_interests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount"
    t.datetime "calendar_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "interestable_type"
    t.uuid "interestable_id"
    t.index ["interestable_type", "interestable_id"], name: "index_on_late_registration_interests_interestable"
  end

  create_table "lessors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "full_name"
    t.string "address"
    t.string "contact_number"
    t.string "email"
    t.uuid "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_lessors_on_business_id"
  end

  create_table "line_of_business_required_documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "line_of_business_id"
    t.uuid "required_document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_of_business_id"], name: "index_on_line_of_business_required_documents"
    t.index ["required_document_id"], name: "index_on_required_document_required_documents"
  end

  create_table "line_of_businesses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.uuid "mayors_permit_fee_business_category_id"
    t.boolean "has_storage_permit_fee", default: false
    t.uuid "competetive_index_category_id"
    t.index ["competetive_index_category_id"], name: "index_line_of_businesses_on_competetive_index_category_id"
    t.index ["mayors_permit_fee_business_category_id"], name: "index_on_permit_fee_business_category"
    t.index ["name"], name: "index_line_of_businesses_on_name", unique: true
    t.index ["slug"], name: "index_line_of_businesses_on_slug", unique: true
  end

  create_table "mayors_permit_fee_business_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_mayors_permit_fee_business_categories_on_name", unique: true
  end

  create_table "mayors_permit_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "line_of_business_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_of_business_id"], name: "index_mayors_permit_fees_on_line_of_business_id"
  end

  create_table "mode_of_payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode"], name: "index_mode_of_payments_on_mode", unique: true
  end

  create_table "municipality_or_cities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "province_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province_id", "name"], name: "index_municipality_or_cities_on_province_id_and_name", unique: true
    t.index ["province_id"], name: "index_municipality_or_cities_on_province_id"
  end

  create_table "occupancy_permit_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.decimal "amount"
    t.datetime "calendar_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_occupancy_permit_fees_on_business_id"
  end

  create_table "other_accessories_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.datetime "calendar_year"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_other_accessories_fees_on_business_id"
  end

  create_table "ownership_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ownership_types_on_name", unique: true
  end

  create_table "payment_schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.decimal "amount"
    t.datetime "payment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_payment_schedules_on_business_id"
  end

  create_table "permit_application_date_ranges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permit_conditions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "content"
    t.boolean "default_condition", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.uuid "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "plumbing_installation_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.datetime "calendar_year"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_plumbing_installation_fees_on_business_id"
  end

  create_table "provinces", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "public_market_tenants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "vendor_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vendor_type"], name: "index_public_market_tenants_on_vendor_type"
  end

  create_table "public_markets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "address"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.decimal "monthly_rent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_rents_on_business_id"
  end

  create_table "required_documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "department_id"
    t.string "name"
    t.boolean "default_requirement", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["department_id"], name: "index_required_documents_on_department_id"
    t.index ["slug"], name: "index_required_documents_on_slug", unique: true
  end

  create_table "revocations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "remarks"
    t.index ["business_id"], name: "index_revocations_on_business_id"
  end

  create_table "sanitary_inspection_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "minimum_area"
    t.decimal "maximum_area"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sealing_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.decimal "amount"
    t.datetime "calendar_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_sealing_fees_on_business_id"
  end

  create_table "sec_registrations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.datetime "date_issued"
    t.datetime "expiry_date"
    t.string "registration_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_sec_registrations_on_business_id"
  end

  create_table "signatories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "designation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "special_permits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "special_permit_type"
    t.decimal "flat_rate"
  end

  create_table "stalls", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "public_market_id"
    t.string "number"
    t.uuid "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stall_type"
    t.index ["business_id"], name: "index_stalls_on_business_id"
    t.index ["number"], name: "index_stalls_on_number"
    t.index ["public_market_id"], name: "index_stalls_on_public_market_id"
    t.index ["stall_type"], name: "index_stalls_on_stall_type"
  end

  create_table "storage_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "fire_dept_collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "amount", default: "0.0"
    t.index ["fire_dept_collection_id"], name: "index_storage_fees_on_fire_dept_collection_id"
  end

  create_table "storage_permit_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.decimal "amount"
    t.decimal "minimum_value"
    t.decimal "maximum_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "surcharges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount"
    t.string "s_type"
    t.uuid "s_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "calendar_year"
    t.string "surchargeable_type"
    t.uuid "surchargeable_id"
    t.index ["s_type", "s_id"], name: "index_surcharges_on_s_type_and_s_id"
    t.index ["surchargeable_type", "surchargeable_id"], name: "index_surcharges_on_surchargeable_type_and_surchargeable_id"
  end

  create_table "tax_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "tax_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxpayer_businesses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_id"
    t.uuid "taxpayer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_taxpayer_businesses_on_business_id"
    t.index ["taxpayer_id"], name: "index_taxpayer_businesses_on_taxpayer_id"
  end

  create_table "taxpayer_special_permits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "special_permit_id"
    t.uuid "taxpayer_id"
    t.decimal "number_of_days"
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal "amount"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["special_permit_id"], name: "index_taxpayer_special_permits_on_special_permit_id"
    t.index ["taxpayer_id"], name: "index_taxpayer_special_permits_on_taxpayer_id"
  end

  create_table "taxpayers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.integer "sex"
    t.string "contact_number"
    t.string "email", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["slug"], name: "index_taxpayers_on_slug", unique: true
  end

  create_table "tins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "tinable_id"
    t.string "tinable_type"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_tins_on_number"
    t.index ["tinable_id"], name: "index_tins_on_tinable_id"
    t.index ["tinable_type"], name: "index_tins_on_tinable_type"
  end

  create_table "tricycle_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.decimal "amount"
    t.boolean "default_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "debit_account_id"
    t.uuid "credit_account_id"
    t.index ["credit_account_id"], name: "index_tricycle_fees_on_credit_account_id"
    t.index ["debit_account_id"], name: "index_tricycle_fees_on_debit_account_id"
  end

  create_table "tricycle_organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "abbreviated_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abbreviated_name"], name: "index_tricycle_organizations_on_abbreviated_name", unique: true
    t.index ["name"], name: "index_tricycle_organizations_on_name", unique: true
  end

  create_table "tricycle_permit_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "tricycle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "application_date"
    t.string "application_number"
    t.integer "transaction_type", default: 1
    t.index ["tricycle_id"], name: "index_tricycle_permit_applications_on_tricycle_id"
  end

  create_table "tricycle_permit_approvals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "date_approved"
    t.string "permit_number"
    t.uuid "tricycle_permit_application_id"
    t.uuid "user_id"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "tricycle_id"
    t.index ["tricycle_id"], name: "index_tricycle_permit_approvals_on_tricycle_id"
    t.index ["tricycle_permit_application_id"], name: "index_on_tricycle_permit_approvals_permit_application"
    t.index ["user_id"], name: "index_tricycle_permit_approvals_on_user_id"
  end

  create_table "tricycle_permit_conditions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "tricycle_permit_approval_id"
    t.uuid "permit_condition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permit_condition_id"], name: "index_tricycle_permit_conditions_on_permit_condition_id"
    t.index ["tricycle_permit_approval_id"], name: "index_tricycle_permit_conditions_on_tricycle_permit_approval_id"
  end

  create_table "tricycle_requirement_verifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "applicable_tricycle_requirement_id"
    t.datetime "verification_date"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicable_tricycle_requirement_id"], name: "index_on_tricycle_requirements_verifications_app_requirements"
    t.index ["user_id"], name: "index_tricycle_requirement_verifications_on_user_id"
  end

  create_table "tricycle_requirements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.boolean "default_requirement", default: false
    t.uuid "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_tricycle_requirements_on_department_id"
  end

  create_table "tricycles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "taxpayer_id"
    t.string "mtop_number"
    t.string "plate_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.uuid "tricycle_organization_id"
    t.index ["status"], name: "index_tricycles_on_status"
    t.index ["taxpayer_id"], name: "index_tricycles_on_taxpayer_id"
    t.index ["tricycle_organization_id"], name: "index_tricycles_on_tricycle_organization_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "department_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "role"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "verifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "business_requirement_id"
    t.string "reference_number"
    t.datetime "submission_date"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_requirement_id"], name: "index_verifications_on_business_requirement_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "zoning_fees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount"
    t.datetime "calendar_year"
    t.uuid "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_zoning_fees_on_business_id"
  end

  add_foreign_key "addresses", "barangays"
  add_foreign_key "addresses", "municipality_or_cities"
  add_foreign_key "addresses", "provinces"
  add_foreign_key "amounts", "accounts"
  add_foreign_key "amounts", "entries"
  add_foreign_key "annual_inspection_fees", "businesses"
  add_foreign_key "applicable_tricycle_fees", "tricycle_fees"
  add_foreign_key "applicable_tricycle_fees", "tricycles"
  add_foreign_key "applicable_tricycle_requirements", "tricycle_requirements"
  add_foreign_key "applicable_tricycle_requirements", "tricycles"
  add_foreign_key "barangays", "municipality_or_cities"
  add_foreign_key "bir_registrations", "businesses"
  add_foreign_key "building_permit_fees", "businesses"
  add_foreign_key "business_activities", "businesses"
  add_foreign_key "business_activities", "line_of_businesses"
  add_foreign_key "business_activities", "storage_permit_fees"
  add_foreign_key "business_areas", "businesses"
  add_foreign_key "business_areas", "sanitary_inspection_fees"
  add_foreign_key "business_capitals", "businesses"
  add_foreign_key "business_fees", "businesses"
  add_foreign_key "business_fees", "fees"
  add_foreign_key "business_permit_applications", "businesses"
  add_foreign_key "business_permit_applications", "taxpayers"
  add_foreign_key "business_permit_approvals", "business_permit_applications"
  add_foreign_key "business_permit_approvals", "users", column: "approver_id"
  add_foreign_key "business_permit_conditions", "business_permit_approvals"
  add_foreign_key "business_permit_conditions", "permit_conditions"
  add_foreign_key "business_requirements", "businesses"
  add_foreign_key "business_requirements", "required_documents"
  add_foreign_key "business_tin_plates", "business_permit_approvals"
  add_foreign_key "business_tin_plates", "businesses"
  add_foreign_key "businesses", "gross_sales_tax_business_categories"
  add_foreign_key "businesses", "gross_sales_tax_configs"
  add_foreign_key "businesses", "lessors"
  add_foreign_key "businesses", "mode_of_payments"
  add_foreign_key "businesses", "ownership_types"
  add_foreign_key "businesses", "public_market_tenants"
  add_foreign_key "cda_registrations", "businesses"
  add_foreign_key "cockpit_details", "businesses"
  add_foreign_key "construction_taxes", "fire_dept_collections"
  add_foreign_key "conveyance_clearance_fees", "fire_dept_collections"
  add_foreign_key "documentary_stamp_fees", "businesses"
  add_foreign_key "dti_registrations", "businesses"
  add_foreign_key "electrical_installation_fees", "businesses"
  add_foreign_key "employee_counts", "businesses"
  add_foreign_key "engineering_penalties", "businesses"
  add_foreign_key "entries", "barangays"
  add_foreign_key "entries", "users"
  add_foreign_key "fare_adjustment_fees", "tricycles"
  add_foreign_key "fees", "accounts", column: "credit_account_id"
  add_foreign_key "fees", "accounts", column: "debit_account_id"
  add_foreign_key "fire_code_fines", "fire_dept_collections"
  add_foreign_key "fire_dept_collections", "entries"
  add_foreign_key "fire_dept_collections", "users", column: "collector_id"
  add_foreign_key "fire_safety_inspection_fee_collections", "businesses"
  add_foreign_key "fire_safety_inspection_fees", "businesses"
  add_foreign_key "fire_safety_inspection_fees", "fire_dept_collections"
  add_foreign_key "gross_sales", "business_activities"
  add_foreign_key "gross_sales", "businesses"
  add_foreign_key "gross_sales_taxes", "gross_sales_tax_business_categories"
  add_foreign_key "gross_sales_taxes", "tax_types"
  add_foreign_key "installation_clearance_fees", "fire_dept_collections"
  add_foreign_key "issuances", "business_requirements"
  add_foreign_key "lessors", "businesses"
  add_foreign_key "line_of_business_required_documents", "line_of_businesses"
  add_foreign_key "line_of_business_required_documents", "required_documents"
  add_foreign_key "line_of_businesses", "competetive_index_categories"
  add_foreign_key "line_of_businesses", "mayors_permit_fee_business_categories"
  add_foreign_key "mayors_permit_fees", "line_of_businesses"
  add_foreign_key "municipality_or_cities", "provinces"
  add_foreign_key "occupancy_permit_fees", "businesses"
  add_foreign_key "other_accessories_fees", "businesses"
  add_foreign_key "payment_schedules", "businesses"
  add_foreign_key "plumbing_installation_fees", "businesses"
  add_foreign_key "rents", "businesses"
  add_foreign_key "required_documents", "departments"
  add_foreign_key "revocations", "businesses"
  add_foreign_key "sealing_fees", "businesses"
  add_foreign_key "sec_registrations", "businesses"
  add_foreign_key "stalls", "businesses"
  add_foreign_key "stalls", "public_markets"
  add_foreign_key "storage_fees", "fire_dept_collections"
  add_foreign_key "taxpayer_businesses", "businesses"
  add_foreign_key "taxpayer_businesses", "taxpayers"
  add_foreign_key "taxpayer_special_permits", "special_permits"
  add_foreign_key "taxpayer_special_permits", "taxpayers"
  add_foreign_key "tricycle_fees", "accounts", column: "credit_account_id"
  add_foreign_key "tricycle_fees", "accounts", column: "debit_account_id"
  add_foreign_key "tricycle_permit_applications", "tricycles"
  add_foreign_key "tricycle_permit_approvals", "tricycle_permit_applications"
  add_foreign_key "tricycle_permit_approvals", "tricycles"
  add_foreign_key "tricycle_permit_approvals", "users"
  add_foreign_key "tricycle_permit_conditions", "permit_conditions"
  add_foreign_key "tricycle_permit_conditions", "tricycle_permit_approvals"
  add_foreign_key "tricycle_requirement_verifications", "applicable_tricycle_requirements"
  add_foreign_key "tricycle_requirement_verifications", "users"
  add_foreign_key "tricycle_requirements", "departments"
  add_foreign_key "tricycles", "taxpayers"
  add_foreign_key "tricycles", "tricycle_organizations"
  add_foreign_key "users", "departments"
  add_foreign_key "verifications", "business_requirements"
  add_foreign_key "zoning_fees", "businesses"
end
