jQuery ->
  output = $('#business-tax-assessment-credit')
  $('#business-tax-assessment-debit').keyup (event) ->
    output.val(this.value)
