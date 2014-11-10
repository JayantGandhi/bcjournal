# Some initialization js for the header
# Dependencies
#   -underscore.js
#   -Jquery


$(window).on 'load', ->
  $header = $('#header')
  $rightBar = $('.right-side')
  $headerOffset = $header.offset().top
  $rightBarOffset = $rightBar.offset().top

  checkSticky = ->
    scrollTop = $(window).scrollTop()
    if scrollTop < $headerOffset
      if $header.hasClass('sticky')
        $header.removeClass('sticky')
    else
      if not $header.hasClass('sticky')
        $header.addClass('sticky')

    if scrollTop < $rightBarOffset
      if $rightBar.hasClass('sticky')
        $rightBar.removeClass('sticky')
    else
      if not $rightBar.hasClass('sticky')
        $rightBar.addClass('sticky')

  do checkSticky

  stickyScroll = _.throttle(checkSticky, 33)

  $(window).on 'scroll', stickyScroll
