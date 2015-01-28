###*
 * link article end notes to the notes section
 * @return
###
linkEndNotes = ($articleNotes) ->
  $noteSection = $('#notes')

  for note in $articleNotes
    $note = $(note)
    noteNumber = $note.text().replace(/[\[\]]+/g, '')
    $note.attr('href', 'note_' + noteNumber)


###*
 * link notes from the old site to the new notes section
 * @return
###
linkOldNotes = ->
  $articleDate = $('article .publish-date')

  isOldArticle = (parseInt($articleDate.text().slice(-4)) < 2015) if $articleDate.length

  if isOldArticle
    $bcJournalNotes = $('.article-content a[href*="bcjournal.org"]')

    linkEndNotes($bcJournalNotes)

$ ->
  do linkOldNotes