module Monitoring
  class RegisteredBusinessesPdf < Prawn::Document
    require 'prawn/table'
    TABLE_WIDTHS = [50, 160, 120, 100, 100 ]

    def initialize(barangay, businesses, from_date, to_date, line_of_business, view_context)
      super(page_size: 'LEGAL', margin: 20, page_layout: :landscape)
      @barangay = barangay
      @businesses = businesses
      @from_date = from_date
      @to_date = to_date
      @line_of_business = line_of_business
      @view_context = view_context
      heading
      businesses_table
    end

    private
    def heading
      text 'Province of Ifugao', size: 8, align: :center
      text 'Municipality of Lamut', size: 8, align: :center
      move_down 5
      text 'BUSINESS PERMITS LICENSING OFFICE', size: 8, align: :center, style: :bold
      move_down 10
      if @barangay.present?
        text "LIST OF REGISTERED BUSINESSES IN #{@barangay.name.upcase}", align: :center, size: 10, style: :bold
      elsif @line_of_business.present?
        text "LIST OF BUSINESSES (#{@line_of_business.name.upcase})", align: :center, size: 10, style: :bold
      else
        text "LIST OF BUSINESSES IN LAMUT", align: :center, size: 10, style: :bold

      end
      if @from_date && @to_date
        text "From: #{@from_date.strftime("%B %e, %Y")} To: #{@to_date.strftime("%B %e, %Y")}", size: 8, align: :center, style: :bold
      end
      move_down 5
      stroke_horizontal_rule
    end

    def businesses_table
      if table_data.empty?
        text "No businesses found.", align: :center
      else
        table table_data,
          cell_style: { size: 8}

      end
    end
    def table_data
      move_down 5
      [["Permit Number", "Application Number", "Business Name", "Type", "Taxpayer", "Gender", "Owner's Address", "Business Address", "Contact", "Line of Business", "# of Employees", "Business Area (sq.m.)", "Gross Sales", "Payment Mode", "CMMI"]] +
      @table_data ||= @businesses.map { |e| [e.permit_number, e.application_number, e.name.try(:upcase), e.business_status, e.taxpayers_full_name.try(:upcase), e.taxpayers_gender, e.taxpayers_address, e.full_address, e.taxpayers_contact_number, e.line_of_businesses_name, e.employee_count.try(:number), e.business_area.try(:area), e.gross_sales.for_current_year, e.mode_of_payment_name, e.competetive_index_categories.pluck(:name).join("/")] }
    end

  end
end
