# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
$('.best_in_place').best_in_place()

$ ->
  $('span.best_in_place').focus ->
    el = $(this)
    el.click()
    el.find(el.data('type')).attr('tabindex', el.attr('tabindex'))