###*
 * Tab Boxes JS
 * Handles all tab related functionality
###

$ ->
  $tabBoxes = $('.tab-box')

  if $tabBoxes.length
    $tabs = $tabBoxes.find('.tab')

    $tabs.on 'click', (e) ->
      $tab = $(e.target).closest('.tab')
      $tabBox = $tab.closest('.tab-box')
      $tabContent = $tabBox.find('#' + $tab.data('tab-content'))
      $allTabContents = $tabBox.find('.tab-content')
      $tabForm = $("[data-tab-content='" + $tab.data('tab-content') + "-form']")
      $tabFormContent = $('#' + $tab.data('tab-content') + '-form')
      $tabGroup = $tabBox.find('.tab')

      $tabGroup.removeClass('active')
      $tab.addClass('active')

      $allTabContents.removeClass('active')
      $tabContent.addClass('active')

      # make tabed form active if exists too
      if $tabForm.length
        $tabBoxForm = $tabForm.closest('.tab-box')
        $tabBoxForm.find('.tab').removeClass('active')
        $tabBoxForm.find('.tab-content').removeClass('active')
        $tabForm.addClass('active')
        $tabFormContent.addClass('active')
