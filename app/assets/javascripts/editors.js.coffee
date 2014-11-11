# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $textArea = $('.text-area-with-limit')

  if $textArea.length

    for element in $textArea
      $element = $(element)
      textAreaMax = $element.attr('max_length')
      initialChars = $element.val().length
      $element.after('<span class="char-counter">' + initialChars + '/' + textAreaMax + '</span>')

    $textArea.on 'keyup', (e)->
      $element = $(e.target)
      chars = $element.val().length
      if chars >= 0
        $element.next('.char-counter').text(chars + '/' + textAreaMax)