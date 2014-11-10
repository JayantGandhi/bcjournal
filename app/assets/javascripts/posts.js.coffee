# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $window = $(window)
  $document = $(document)

  init = ->
    do infiniteScroll

  infiniteScroll = ->
    # infinite pagination
    if $('.pagination').length
      $window.scroll ->
        url = $('.pagination .next_page').attr('href')

        if url && $window.scrollTop() > $document.height() - $window.height() - 50
          $('.pagination').replaceWith('<div class="loader pagination"><img src="/assets/icons/ajax-loader.gif"></div>')
          $.getScript url

      do $window.scroll

  do init
