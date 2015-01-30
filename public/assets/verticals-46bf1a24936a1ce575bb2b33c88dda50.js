(function() {
  $(function() {
    var $verticalLinks;
    $verticalLinks = $('.vertical-link');
    return $verticalLinks.on('click', function(e) {
      var $vertical, $verticalWrapper, currentURL, url, verticalSlug;
      $vertical = $(e.target);
      $verticalWrapper = $vertical.parent();
      verticalSlug = $vertical.data('vertical');
      currentURL = window.location.href;
      url = '/posts/vertical/' + verticalSlug;
      $('.pagination').remove();
      return $.getScript(url, function() {
        $('.vertical-link').removeClass('active');
        $('.' + verticalSlug).addClass('active');
        return history.pushState(null, '', url);
      });
    });
  });

}).call(this);
