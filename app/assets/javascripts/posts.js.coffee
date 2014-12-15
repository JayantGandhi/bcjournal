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
          $.getScript url, ->
            do setAbstractListeners

      do $window.scroll

  do init

  $sectionNavigator = $('.section-navigator')

  if $sectionNavigator.length
    $progressBar = $('.progress-bar')
    docHeight = $document.height()

    $titleArea = $('section.title-area')
    titleAreaBottom = $titleArea.offset().top + $titleArea.height()

    if $window.scrollTop() > titleAreaBottom
      $sectionNavigator.addClass('shown')

    articleHeight = $('.article-content').height()
    articleOffset = $('.article-content').offset().top

    $sections = $('.article-content section')

    nanobar = new Nanobar({
      'id': 'nanobar'
    })

    checkProgress = ->
      scrollTop = $window.scrollTop()
      scrollBottom = scrollTop + $window.height()

      if scrollBottom > articleOffset
        percentage = (scrollBottom - articleOffset)/articleHeight * 100
        nanobar.go(percentage)

      if $window.scrollTop() > titleAreaBottom
        $sectionNavigator.addClass('shown')
      else
        $sectionNavigator.removeClass('shown')

      for section in $sections
        $section = $(section)
        sectionBottom = $section.offset().top + $section.height()
        id = $section.attr('id')

        if id isnt ''
          $link = $('.section-navigator a[href="#' + id + '"]')

          if scrollBottom > sectionBottom
            $link.parent().removeClass('highlighted')
          else if scrollBottom <= $(section).offset().top
            $link.parent().removeClass('highlighted')
          else if scrollBottom > $(section).offset().top
            $link.parent().addClass('highlighted')
    throttledProgress = _.throttle(checkProgress, 33)

    $window.on 'scroll', throttledProgress

  # Set listener on abstract link
  setAbstractListeners = ->
    $('.abstract-link').on 'click', (e) ->
      targetID = $(e.target).data('target')
      $target = $('#' + targetID)
      # show abstract lightbox on click
      $target.addClass('shown').removeClass('visibly-hidden')

      $target.find('.close').on 'click', ->
        $target.removeClass('shown').addClass('visibly-hidden')
      $target.on 'click', ->
        $target.removeClass('shown').addClass('visibly-hidden')
