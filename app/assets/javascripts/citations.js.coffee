###*
 * citation JS
###

selectText = (element) ->
  doc = document
  text = element

  if doc.body.createTextRange
    range = document.body.createTextRange()
    range.moveToElementText(text)
    range.select()
  else if window.getSelection
    selection = window.getSelection()
    range = document.createRange()
    range.selectNodeContents(text)
    selection.removeAllRanges()
    selection.addRange(range)

$ ->
  $('.citation').on 'click', ->
    selectText(this)

