require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/prawn_outputter'
class BusinessPermitPdf < Prawn::Document
  def initialize(business_permit, view_context)
    super(page_size: 'A4', margin: 30)
    @business_permit = business_permit
    @view_context = view_context
    logo
    heading
    business_info
    dates
    taxpayer
    signatory
    assessment_details
    conditions
    footer
  end
  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end
  def logo
    image "#{Rails.root}/app/assets/images/logo.png", width: 75, height: 75, :at => [40, 800]
    draw_text "UMUNA TI LAMUT", size: 9, :at => [40, 715]
  end
  def heading
    text 'Republic of the Philippines', size: 10, align: :center
    text 'Province of Ifugao', size: 10, align: :center
    text 'MUNICIPALITY OF LAMUT', size: 10, align: :center
    move_down 5
    text 'OFFICE OF THE MUNICIPAL MAYOR', size: 10, align: :center, style: :bold
    move_down 25
    text "MAYOR'S PERMIT", align: :center, size: 28, style: :bold
    stroke_horizontal_rule
  end
  def business_info
    bounding_box([0, 670], :width => 600, :height => 100) do
      table business_info_table_data,
        column_widths: [100, 150, 150, 150] do
        cells.borders = []
        row(0).font_style = :italic
        row(0).size = 8

        row(0).align = :center
        row(1).align = :center
        row(1).size = 20
        row(1).font_style = :bold

      end
    end
  end
  def business_info_table_data
    [["BUSINESS PLATE NO.", "TRANSACTION TYPE", "BUSINESS PERMIT NO.", "YEAR"]] +
    [["#{@business_permit.business_tin_plate.try(:number)}", "#{@business_permit.transaction_type.gsub("_application", "").upcase}", "#{@business_permit.permit_number}", "#{Time.zone.now.year}"]]
  end
  def taxpayer
    bounding_box([0, 600], :width => 350) do
      text "IS HEREBY GRANTED TO", align: :center, size: 10, style: :italic
      move_down 10
      text "NAME OF TAXPAYER", size: 10, style: :italic, align: :center
      move_down 2
      text "#{@business_permit.business_taxpayers_full_name.upcase}",  align: :center, style: :bold, size: 16
      move_down 10
      text "BUSINESS TRADENAME", size: 10, style: :italic, align: :center
      move_down 2
      text "#{@business_permit.business_name.upcase}",  align: :center, style: :bold, size: 16
      move_down 10
      text "BUSINESS ADDRESS", size: 10, style: :italic, align: :center
      move_down 2
      text "#{@business_permit.business_full_address.upcase}",  align: :center, style: :bold, size: 10
      move_down 10
      text "to engage, operate and/or continue their business", align: :center, size: 10, style: :italic
      move_down 5
      text "LINE(S) OF BUSINESS", size: 10, style: :italic
      table line_of_business_table_data,
      cell_style: { size: 10, padding: [0,0,2,0], inline_format: true }, column_widths: [20, 310] do
        cells.borders = []
      end
    end
  end
  def line_of_business_table_data
    @line_of_business_table_data ||= @business_permit.business.business_activities.map{|e| ["(#{e.number_of_unit})", "<b>#{e.line_of_business.name.upcase}</b>"] }
  end

  def dates

  end





  def signatory
    bounding_box [0, 290], width: 350 do
      text "Approved By:"
      move_down 30
      text "#{BploSection::Settings::Signatory.order(created_at: :asc).last.try(:full_name).try(:upcase)}", align: :center, size: 14, style: :bold
      text "#{BploSection::Settings::Signatory.order(created_at: :asc).last.try(:designation).try(:upcase)}", align: :center, size: 10
      move_down 10
      text "Having complied with the provisions of the Municipal Tax Ordinance and the rules and regulations issued pursuant thereto.", align: :center, size: 9
      text "This permit is revoked/cancelled once the conditions stipulated in his/her application is violated.", align: :center, size: 9

    end
  end
  def assessment_details
    bounding_box([365, 600], :width => 190) do
      move_down 5
      text "ASSESSMENT DETAILS", style: :bold, size: 9
      move_down 3
      if assessment_table_data.empty?
        text "No assessments"
      else
        table assessment_table_data,
        cell_style: { size: 7, padding: [0,0,4,0], inline_format: true  }, column_widths: [120, 60] do
          cells.borders = []
          column(1).align = :right
        end


        move_down 20
        text "PAYMENT DETAILS", style: :bold, size: 9


        table payment_table_data,
        cell_style: { size: 7, padding: [0,0,4,0], }, column_widths: [120, 60] do
          cells.borders = []
          column(1).align = :right
        end
        move_down 10
        stroke_horizontal_rule
        move_down 20
        text "#{@business_permit.date_approved.strftime("%B %e, %Y")}", style: :bold, size: 10, align: :center
        text "DATE APPROVED",  size: 9, align: :center
        move_down 20
        text "#{Time.zone.now.end_of_year.strftime("%B %e, %Y")}",  style: :bold, size: 10, align: :center
        text "EXPIRY DATE", size: 9, align: :center

      end
    end
  end
  def assessment_table_data
    @assessment_table_data ||= @business_permit.business.assessment_details_for_current_year.credit_amounts.map { |e| [e.account.try(:name).gsub("Accounts Receivable - ", "").gsub("Income", "").try(:upcase).try(:singularize), price(e.amount)] } +
    [["<b>TOTAL</b>",  "<b>#{price(@business_permit.business.assessment_details_for_current_year.debit_amounts.sum(&:amount))}</b>"]] +
    [["", ""]] +
    [["<b>BUREAU OF FIRE PROTECTION</b>", "<b>#{price(@business_permit.business.payment_details_for_current_year.try(:fire_dept_collection).try(:total))}</b>"]]
  end
  def payment_table_data
    [[ "MODE OF PAYMENT",  "#{@business_permit.business.mode_of_payment.try(:mode).try(:upcase)}"]] +
    [[ "AMOUNT PAID", "#{price(@business_permit.business.payment_details_for_current_year.debit_amounts.sum(&:amount))}"]] +
    [[ "OFFICIAL RECEIPT", "#{@business_permit.business.payment_details_for_current_year.try(:reference_number)}"]] +
    [[ "DATE PAID", "#{@business_permit.business.payment_details_for_current_year.entry_date.strftime("%D")}"]]
  end
  def conditions
    bounding_box([0, 160], :width => 700) do
      text "CONDITIONS FOR THE VALIDATION OF THIS PERMIT:", size: 10, style: :italic
      table condition_table_data,
      cell_style: { size: 8, padding: [0,0,4,0], }, column_widths: [500] do
        cells.borders = []
        column(1).align = :right
      end
    end
  end

  def condition_table_data
    @condition_table_data ||= @business_permit.permit_conditions.map{|p| [ "* #{p.content}" ] }
  end
  def footer
    bounding_box([0, 10], width: 170) do
      barcode = Barby::Code128.new(@business_permit.permit_number)
      barcode.annotate_pdf(self, height: 20)
      move_down 3
      text "PERMIT NO. #{@business_permit.permit_number}", size: 6
    end

    bounding_box([365, 10], width: 600) do
      barcode = Barby::Code128.new(@business_permit.business.payment_details_for_current_year.try(:reference_number))
      barcode.annotate_pdf(self, height: 20)
      move_down 3
      text "OFFICIAL RECEIPT: #{@business_permit.business.payment_details_for_current_year.try(:reference_number)}", size: 6
    end
  end
end
