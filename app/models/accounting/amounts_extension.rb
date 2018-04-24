module Accounting
  module AmountsExtension
    def balance(options={})
      first_entry_date = Accounting::Entry.order(entry_date: :desc).last.try(:entry_date) || Date.today
      from_date = options[:from_date]
      to_date = options[:to_date]
      commercial_document = options[:commercial_document]
      if commercial_document.present? && from_date.present? && to_date.present?
        balance_for(options).
        entered_on(options).
        sum(:amount)
      elsif commercial_document.blank? && from_date.present? && to_date.present?
        entered_on(options).
        sum(:amount)
      elsif commercial_document.present? && from_date.blank? && to_date.blank?
        balance_for(options).
        sum(:amount)
      elsif commercial_document.blank? && from_date.blank? && to_date.present?
        entered_on(options).
        sum(:amount)
      else
        joins(:entry, :account).
        sum(:amount)
      end
    end

    def balance_for(options={})
      joins(:entry, :account).
      where(commercial_document: options[:commercial_document])
    end


    def balance_for_new_record
      balance = BigDecimal.new('0')
      each do |amount_record|
        if amount_record.amount && !amount_record.marked_for_destruction?
          balance += amount_record.amount # unless amount_record.marked_for_destruction?
        end
      end
      return balance
    end
  end
end
