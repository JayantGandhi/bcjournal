(function() {
  jQuery(function() {
    var $document, $progressBar, $sectionNavigator, $sections, $titleArea, $window, articleHeight, articleOffset, checkProgress, docHeight, infiniteScroll, init, nanobar, setAbstractListeners, throttledProgress, titleAreaBottom;
    $window = $(window);
    $document = $(document);
    init = function() {
      return infiniteScroll();
    };
    infiniteScroll = function() {
      if ($('.pagination').length) {
        $window.scroll(function() {
          var url;
          url = $('.pagination .next_page').attr('href');
          if (url && $window.scrollTop() > $document.height() - $window.height() - 50 && $('.pagination').length) {
            $('.pagination').replaceWith('<div class="loader pagination"><img alt="Ajax loader" src="/assets/icons/ajax-loader.gif" /></div>');
            return $.getScript(url, function() {
              return setAbstractListeners();
            });
          }
        });
        return $window.scroll();
      }
    };
    init();
    $sectionNavigator = $('.section-navigator');
    if ($sectionNavigator.length) {
      $progressBar = $('.progress-bar');
      docHeight = $document.height();
      $titleArea = $('section.title-area');
      titleAreaBottom = $titleArea.offset().top + $titleArea.height();
      if ($window.scrollTop() > titleAreaBottom) {
        $sectionNavigator.addClass('shown');
      }
      articleHeight = $('.article-content').height();
      articleOffset = $('.article-content').offset().top;
      $sections = $('.article-content section');
      nanobar = new Nanobar({
        'id': 'nanobar'
      });
      checkProgress = function() {
        var $link, $section, id, percentage, scrollBottom, scrollTop, section, sectionBottom, _i, _len, _results;
        scrollTop = $window.scrollTop();
        scrollBottom = scrollTop + $window.height();
        if (scrollBottom > articleOffset) {
          percentage = (scrollBottom - articleOffset) / articleHeight * 100;
          nanobar.go(percentage);
        }
        if ($window.scrollTop() > titleAreaBottom) {
          $sectionNavigator.addClass('shown');
        } else {
          $sectionNavigator.removeClass('shown');
        }
        _results = [];
        for (_i = 0, _len = $sections.length; _i < _len; _i++) {
          section = $sections[_i];
          $section = $(section);
          sectionBottom = $section.offset().top + $section.height();
          id = $section.attr('id');
          if (id !== '') {
            $link = $('.section-navigator a[href="#' + id + '"]');
            if (scrollBottom > sectionBottom) {
              _results.push($link.parent().removeClass('highlighted'));
            } else if (scrollBottom <= $(section).offset().top) {
              _results.push($link.parent().removeClass('highlighted'));
            } else if (scrollBottom > $(section).offset().top) {
              _results.push($link.parent().addClass('highlighted'));
            } else {
              _results.push(void 0);
            }
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };
      throttledProgress = _.throttle(checkProgress, 33);
      $window.on('scroll', throttledProgress);
    }
    setAbstractListeners = function() {
      return $('.abstract-link').on('click', function(e) {
        var $target, targetID;
        targetID = $(e.target).data('target');
        $target = $('#' + targetID);
        $target.addClass('shown').removeClass('visibly-hidden');
        $target.find('.close').on('click', function() {
          return $target.removeClass('shown').addClass('visibly-hidden');
        });
        return $target.on('click', function() {
          return $target.removeClass('shown').addClass('visibly-hidden');
        });
      });
    };
    return setAbstractListeners();
  });

}).call(this);
