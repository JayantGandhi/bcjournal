# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $textArea = $('.text-area-with-limit')

  if $textArea.length
    textAreaMax = $textArea.attr('max_length')
    initialChars = $textArea.val().length
    $textArea.after('<span class="char-counter">' + initialChars + '/' + textAreaMax + '</span>')

    $textArea.on 'keyup', ->
      chars = $textArea.val().length
      if chars >= 0
        $textArea.next('.char-counter').text(chars + '/' + textAreaMax)