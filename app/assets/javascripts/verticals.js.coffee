# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $verticalLinks = $('.vertical-link')

  $verticalLinks.on 'click', (e) ->
    $vertical = $(e.target)
    $verticalWrapper = $vertical.parent()
    verticalSlug = $vertical.data('vertical')
    currentURL = window.location.href

    # find all active verticals
    $activeVerticals = $('.vertical-link.active a')

    # verticals previously selected
    if $activeVerticals.length > 0
      wasActive = false

      verticalSlugs = currentURL.split('/').
                        pop().
                        replace('posts#', '').
                        split('+')

      for vertical in $activeVerticals
        if vertical = $vertical[0]
          $verticalWrapper.removeClass('active')
          verticalSlugs = verticalSlugs.filter (slug) -> slug isnt verticalSlug
          wasActive = true

      # if wasActive
      #   # it was not the last vertical active
      #   if verticalSlugs.length
      #     url = '/posts/vertical/' + verticalSlugs.join('+')
      #   # it WAS the last vertical active
      #   else
      #     # TODO: make this less sucky
      #     window.location.href = '/posts'
      # else
      #   verticalSlugs.push(verticalSlug)
      #   url = '/posts/vertical/' + verticalSlugs.join('+')

      if wasActive and verticalSlugs.length <= 0
        window.location.href = '/posts'
      else
        verticalSlugs.push(verticalSlug) if not wasActive

        url = '/posts/vertical/' + verticalSlugs.join('+')

    # no verticals previously selected
    else
      url = '/posts/vertical/' + verticalSlug

      $('.pagination').remove()
      $.getScript url, ->
        $('.vertical-link').removeClass('active')
        $('.' + verticalSlug).addClass('active')
        history.pushState(null, '', url)