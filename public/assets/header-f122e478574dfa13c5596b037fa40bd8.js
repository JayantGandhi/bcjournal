(function() {
  $(window).on('load', function() {
    var $header, $headerOffset, $relatedArticles, $rightBar, $rightBarOffset, $stickySocial, $stickySocialOffset, checkSticky, stickyScroll;
    $header = $('#header');
    $rightBar = $('.right-side');
    if ($header.length) {
      $headerOffset = $header.offset().top;
    }
    if ($rightBar.length) {
      $rightBarOffset = $rightBar.offset().top;
    }
    $stickySocial = $('.sticky-social');
    if ($stickySocial.length) {
      $stickySocialOffset = $stickySocial.offset().top;
    }
    $relatedArticles = $('.related-articles');
    checkSticky = function() {
      var scrollTop;
      scrollTop = $(window).scrollTop();
      if ($header.length) {
        if (scrollTop < $headerOffset) {
          if ($header.hasClass('sticky')) {
            $header.removeClass('sticky');
          }
        } else {
          if (!$header.hasClass('sticky')) {
            $header.addClass('sticky');
          }
        }
      }
      if ($rightBar.length) {
        if (scrollTop < $rightBarOffset) {
          if ($rightBar.hasClass('sticky')) {
            $rightBar.removeClass('sticky');
          }
        } else {
          if (!$rightBar.hasClass('sticky')) {
            $rightBar.addClass('sticky');
          }
        }
      }
      if ($stickySocial.length) {
        if (scrollTop < $stickySocialOffset) {
          if ($stickySocial.hasClass('sticky')) {
            $stickySocial.removeClass('sticky');
            if ($relatedArticles.length) {
              return $relatedArticles.removeClass('sticky');
            }
          }
        } else {
          if (!$stickySocial.hasClass('sticky')) {
            $stickySocial.addClass('sticky');
            if ($relatedArticles.length) {
              return $relatedArticles.addClass('sticky');
            }
          }
        }
      }
    };
    checkSticky();
    $('.page-wrap').on('click', function(e) {
      if ($('#mobile-nav').width() > 0) {
        e.preventDefault();
        return window.location.hash = '';
      }
    });
    stickyScroll = _.throttle(checkSticky, 33);
    return $(window).on('scroll', stickyScroll);
  });

}).call(this);
