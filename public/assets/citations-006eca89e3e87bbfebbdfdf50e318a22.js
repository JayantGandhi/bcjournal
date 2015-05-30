
/**
 * citation JS
 */

(function() {
  var selectText;

  selectText = function(element) {
    var doc, range, selection, text;
    doc = document;
    text = element;
    if (doc.body.createTextRange) {
      range = document.body.createTextRange();
      range.moveToElementText(text);
      return range.select();
    } else if (window.getSelection) {
      selection = window.getSelection();
      range = document.createRange();
      range.selectNodeContents(text);
      selection.removeAllRanges();
      return selection.addRange(range);
    }
  };

  $(function() {
    $('.citation').on('click', function() {
      return selectText(this);
    });
    $('.modal-dialog').on('click', function(e) {
      return e.stopPropagation();
    });
    return $('.modal').on('click', function(e) {
      window.location.hash = 'close';
      return e.preventDefault();
    });
  });

}).call(this);
