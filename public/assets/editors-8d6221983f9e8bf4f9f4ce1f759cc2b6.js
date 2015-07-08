(function() {
  $(function() {
    var $element, $sectionsContainer, $textArea, element, initialChars, textAreaMax, _i, _len;
    $textArea = $('.text-area-with-limit');
    if ($textArea.length) {
      for (_i = 0, _len = $textArea.length; _i < _len; _i++) {
        element = $textArea[_i];
        $element = $(element);
        textAreaMax = $element.attr('max_length');
        initialChars = $element.val().length;
        $element.after('<span class="char-counter">' + initialChars + '/' + textAreaMax + '</span>');
      }
      $textArea.on('keyup', function(e) {
        var chars;
        $element = $(e.target);
        chars = $element.val().length;
        if (chars >= 0) {
          return $element.next('.char-counter').text(chars + '/' + textAreaMax);
        }
      });
    }
    $sectionsContainer = $('#sections');
    $sectionsContainer.on('cocoon:after-insert', function(e, insertedItem) {
      var $latestPositionInput, sectionsCount;
      sectionsCount = $sectionsContainer.find('.nested-fields').length;
      $latestPositionInput = $sectionsContainer.find(':input[type=number]').last();
      return $latestPositionInput.val(sectionsCount);
    });
    return $sectionsContainer.on('cocoon:after-remove', function(e, removedItem) {
      var $positionInputs, i, input, _j, _len1, _results;
      $positionInputs = $sectionsContainer.find(':input[type=number]');
      _results = [];
      for (i = _j = 0, _len1 = $positionInputs.length; _j < _len1; i = ++_j) {
        input = $positionInputs[i];
        _results.push($(input).val(i + 1));
      }
      return _results;
    });
  });

}).call(this);
