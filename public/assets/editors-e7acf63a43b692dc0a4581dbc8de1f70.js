(function() {
  $(function() {
    var $element, $textArea, element, initialChars, textAreaMax, _i, _len;
    $textArea = $('.text-area-with-limit');
    if ($textArea.length) {
      for (_i = 0, _len = $textArea.length; _i < _len; _i++) {
        element = $textArea[_i];
        $element = $(element);
        textAreaMax = $element.attr('max_length');
        initialChars = $element.val().length;
        $element.after('<span class="char-counter">' + initialChars + '/' + textAreaMax + '</span>');
      }
      return $textArea.on('keyup', function(e) {
        var chars;
        $element = $(e.target);
        chars = $element.val().length;
        if (chars >= 0) {
          return $element.next('.char-counter').text(chars + '/' + textAreaMax);
        }
      });
    }
  });

}).call(this);
