module Accounting
  class PaymentPdf < Prawn::Document
    require 'prawn/table'
    TABLE_WIDTHS = [50, 160, 120, 100, 100 ]

    def initialize(entry, view_context)
      super(page_size: 'A4', margin: 50, page_layout: :portrait)
      @entry = entry
      @view_context = view_context
      heading
      business_details
      entry_details
      assessee_details

    end

    private
    def price(number)
      @view_context.number_to_currency(number, :unit => "P ")
    end

    def heading
      text 'Province of Ifugao', size: 9, align: :center
      text 'Municipality of Lamut', size: 9, align: :center
      move_down 5
      text 'MUNICIPAL TREASURY OFFICE', size: 9, align: :center, style: :bold
      move_down 10
      if @entry.assessment?
        text "ASSESSMENT DETAILS", align: :center, size: 10, style: :bold
      elsif @entry.payment?
        text "PAYMENT DETAILS", align: :center, size: 10, style: :bold
      end


      stroke_horizontal_rule
    end
    def business_details
      move_down 10
      text "Business Name:      #{@entry.commercial_document.try(:name).try(:upcase)}", size: 10
      move_down 5
      text "Taxpayer:                 #{@entry.commercial_document.taxpayers_full_name.try(:upcase)}", size: 10
      move_down 5
      text "Date Assessed:       #{@entry.entry_date.strftime("%B %e, %Y")}", size: 10
      move_down 5
      if @entry.payment?
        text "Official Receipt Number:       #{@entry.reference_number}", size: 10
      end
      stroke_horizontal_rule
    end
    def entry_details
      if table_data.empty?
        text "No data.", align: :center
      else
        table table_data,
        cell_style: { size: 9, padding: [0,0,4,0], inline_format: true  }, column_widths: [150, 80] do
          cells.borders = []
          row(0).style = :bold
          column(1).align = :right
        end
        move_down 5
        stroke_horizontal_rule

      end
    end
    def table_data
      move_down 5
      [["FEE / TAX", "AMOUNT"]] +
      @table_data ||= @entry.credit_amounts.order(amount: :asc).map { |e| [e.account.try(:name).gsub("Accounts Receivable -", "").gsub('Income', "").singularize, price(e.amount)] } +
      [["", "_________"]] +
      [["<b>TOTAL</b>", "<b>#{price(@entry.debit_amounts.sum(:amount))}</b>"]]
    end
    def assessee_details
      move_down 20
      if @entry.assessment?
        text "ASSESSED BY:", size: 8
      elsif @entry.payment?
        text "COLLECTED BY:", size: 8
      end

      move_down 30
      text "#{@entry.recorder.try(:full_name).try(:upcase)}", size: 10, style: :bold
      text "#{@entry.recorder.try(:role).try(:titleize).try(:upcase)}", size: 8
    end

  end
end
