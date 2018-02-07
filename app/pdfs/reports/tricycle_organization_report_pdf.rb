module Reports
  class TricycleOrganizationReportPdf < Prawn::Document
    require 'prawn/table'
    TABLE_WIDTHS = [50, 160, 120, 100, 100 ]

    def initialize(organization, view_context)
      super(page_size: 'LEGAL', margin: 20, page_layout: :portrait)

      @organization = organization
      @view_context = view_context
      heading
      logo
      tricycle_organization_table
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
      
       text "LIST OF TRICYCLES UNDER #{@organization.abbreviated_name}", align: :center, size: 10, style: :bold

      move_down 10
    end
    def logo
      image "#{Rails.root}/app/assets/images/logo.png", width: 75, height: 75, :at => [40, 975]
    end

    def tricycle_organization_table
      if table_data.empty?
        text "No tricycles found.", align: :center
      else
        table table_data,
        cell_style: { size: 8,  inline_format: true  }, column_widths: [200, 100, 100, 150] do
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
      [[ "Taxpayer", "MTOP Number", "Plate Number", "Organization"]] +
      @table_data ||= @organization.tricycles.map { |e| [e.taxpayer.try(:full_name), e.mtop_number, e.plate_number, e.tricycle_organization.try(:abbreviated_name)] }
    end

  end
end
