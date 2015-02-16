# Some initialization js for the header
# Dependencies
#   -underscore.js
#   -Jquery


$(window).on 'load', ->
  $header = $('#header')
  $rightBar = $('.right-side')
  $headerOffset = $header.offset().top if $header.length
  $rightBarOffset = $rightBar.offset().top if $rightBar.length
  $stickySocial = $('.sticky-social')
  $stickySocialOffset = $stickySocial.offset().top if $stickySocial.length
  $relatedArticles = $('.related-articles')

  checkSticky = ->
    scrollTop = $(window).scrollTop()
    if $header.length
      if scrollTop < $headerOffset
        if $header.hasClass('sticky')
          $header.removeClass('sticky')
      else
        if not $header.hasClass('sticky')
          $header.addClass('sticky')

    if $rightBar.length
      if scrollTop < $rightBarOffset
        if $rightBar.hasClass('sticky')
          $rightBar.removeClass('sticky')
      else
        if not $rightBar.hasClass('sticky')
          $rightBar.addClass('sticky')

    if $stickySocial.length
      if scrollTop < $stickySocialOffset
        if $stickySocial.hasClass('sticky')
          $stickySocial.removeClass('sticky')
          $relatedArticles.removeClass('sticky') if $relatedArticles.length
      else
        if not $stickySocial.hasClass('sticky')
          $stickySocial.addClass('sticky')
          $relatedArticles.addClass('sticky') if $relatedArticles.length

  do checkSticky

  $('.page-wrap').on 'click', (e) ->
    if $('#mobile-nav').width() > 0
      e.preventDefault()
      window.location.hash = ''

  stickyScroll = _.throttle(checkSticky, 33)

  $(window).on 'scroll', stickyScroll
