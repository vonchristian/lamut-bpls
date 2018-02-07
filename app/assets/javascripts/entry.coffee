jQuery ->
  output = $('#accounting_entry_credit_amounts_attributes_0_amount')
  $('#accounting_entry_debit_amounts_attributes_0_amount').keyup (event) ->
    output.val(this.value)

jQuery ->
  output = $('#business-tax-form-credit-entry')
  $('#business-tax-form-debit-entry').keyup (event) ->
    output.val(this.value)
