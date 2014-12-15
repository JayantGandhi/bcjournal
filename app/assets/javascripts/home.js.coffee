# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # hide arrows if only one slide
  if $('.slick-slide').length <= 1
    $('.slide-arrow').addClass('hide')
