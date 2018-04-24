module Reports
  class RetiredBusinessReportPdf < Prawn::Document
    require 'prawn/table'
    TABLE_WIDTHS = [50, 160, 120, 100, 100 ]

    def initialize(businesses, barangay, view_context)
      super(page_size: 'LEGAL', margin: 20, page_layout: :landscape)

      @businesses = businesses
      @barangay = barangay
      @view_context = view_context
      heading
      logo
      businesses_table
    end

    private
    def price(number)
      @view_context.number_to_currency(number, :unit => "P ")
    end

    def heading
      text 'Republic of the Philippines', size: 8, align: :center
      text 'Province of Ifugao', size: 8, align: :center
      text 'Municipality of Lamut', size: 8, align: :center
      move_down 5
      text 'BUSINESS PERMITS LICENSING OFFICE', size: 8, align: :center, style: :bold
      move_down 10
      if @barangay.present?
        text "RETIRED BUSINESSES IN #{@barangay.name.try(:upcase)}", align: :center, size: 10, style: :bold
      else
        text "RETIRED BUSINESSES IN LAMUT", align: :center, size: 10, style: :bold
      end
      move_down 10
    end
    def logo
      image "#{Rails.root}/app/assets/images/logo.png", width: 75, height: 75, :at => [40, 580]
    end

    def businesses_table
      if table_data.empty?
        text "No businesses found.", align: :center
      else
        table table_data,
        cell_style: { size: 8,  inline_format: true  }, column_widths: [70, 100, 40, 120, 80, 40, 170, 100, 60, 60, 60, 60] do
          row(0).font_style = :bold
          column(8).align = :right
          column(9).align = :right
          column(10).align = :right
          column(11).align = :right



        end
      end
    end
    def table_data
      move_down 5
      [["Date of Registration", "Taxpayer", "Business Type", "Business Name",  "Business Address", "# of Employees", "Line of Business", "Classification", "Capital", "Gross Sales", "Mayors Permit Fee", "Business Tax"]] +
      @table_data ||= @businesses.map { |e| [e.date_registered, e.taxpayers_full_name, e.business_status, e.name.try(:upcase),  e.full_address, e.employee_count.try(:number), e.line_of_businesses_name, e.competetive_index_categories.pluck(:name).join("/"), price(e.business_capital.try(:amount)), e.gross_sales.for_current_year, price(e.total_paid_mayors_permit_fees), price(e.total_paid_business_taxes)] }
    end

  end
end
