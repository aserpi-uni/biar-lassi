#styles form controls that have an error
$(document).on "turbolinks:load", ->
  fieldset = $('.errored').parent()
  fieldset.addClass('has-danger')
  fieldset.parent().find('.fa').css('color', '#f44336')

$(document).on "turbolinks:load", ->
  $('body').bootstrapMaterialDesign()
