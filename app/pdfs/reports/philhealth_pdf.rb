module Reports
  class PhilhealthPdf < Prawn::Document
    require 'prawn/table'
    TABLE_WIDTHS = [50, 160, 120, 100, 100 ]

    def initialize(businesses, from_date, to_date, view_context)
      super(page_size: 'LEGAL', margin: 20, page_layout: :portrait)

      @businesses = businesses
      @from_date = from_date
      @to_date = to_date
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
        text "LIST OF REGISTERED BUSINESSES IN #{@barangay.name.upcase}", align: :center, size: 10, style: :bold
      elsif @line_of_business.present?
        text "LIST OF BUSINESSES UNDER #{@line_of_business.name.upcase}", align: :center, size: 10, style: :bold
      else
        text "LIST OF BUSINESSES IN LAMUT", align: :center, size: 10, style: :bold

      end
      if @from_date && @to_date
        text "From: #{@from_date.strftime("%B %e, %Y")} To: #{@to_date.strftime("%B %e, %Y")}", size: 8, align: :center, style: :bold
      end
      move_down 10
    end
    def logo
      image "#{Rails.root}/app/assets/images/logo.png", width: 75, height: 75, :at => [40, 975]
    end

    def businesses_table
      if table_data.empty?
        text "No businesses found.", align: :center
      else
        table table_data,
        cell_style: { size: 8,  inline_format: true  }, column_widths: [] do
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
      [["Business Name",  "Business Address", "Taxpayer",  "Business Type", "Contact #", "# of Employees", "Type"]] +
      @table_data ||= @businesses.map { |e| [e.name.try(:upcase),  e.full_address, e.taxpayers_full_name.try(:upcase), e.business_status, e.taxpayers_contact_number, e.employee_count.try(:number), e.ownership_type_name] }
    end

  end
end
