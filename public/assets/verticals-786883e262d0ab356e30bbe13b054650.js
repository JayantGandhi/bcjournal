(function() {
  $(function() {
    var $verticalLinks;
    $verticalLinks = $('.vertical-link');
    return $verticalLinks.on('click', function(e) {
      var $vertical, $verticalWrapper, currentURL, url, verticalSlug, weAreHome;
      weAreHome = $('#homeHeader').length;
      console.log(weAreHome);
      if (weAreHome) {
        currentURL = window.location.href;
        e.preventDefault();
        $vertical = $(e.target);
        $verticalWrapper = $vertical.parent();
        verticalSlug = $vertical.data('vertical');
        url = '/posts/vertical/' + verticalSlug;
        $('.pagination').remove();
        return $.getScript(url, function() {
          $('.vertical-link').removeClass('active');
          $('.' + verticalSlug).addClass('active');
          return history.pushState(null, '', url);
        });
      }
    });
  });

}).call(this);
