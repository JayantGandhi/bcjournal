# Some initialization js for the header
# Dependencies
#   -underscore.js
#   -Jquery


$(window).on 'load', ->
  $header = $('#header')
  $headerOffset = $header.offset().top

  checkSticky = ->
    scrollTop = $(window).scrollTop()
    console.log scrollTop
    console.log $headerOffset
    if scrollTop < $headerOffset
      if $header.hasClass('sticky')
        $header.removeClass('sticky')
    else
      if not $header.hasClass('sticky')
        $header.addClass('sticky')

  stickyScroll = _.throttle(checkSticky, 33)

  $(window).on 'scroll', stickyScroll
