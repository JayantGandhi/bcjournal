(function() {
  var postToFeed;

  postToFeed = function(title, desc, url, image) {
    var callback, obj;
    callback = function(response) {};
    obj = {
      method: "feed",
      link: url,
      picture: image,
      name: title,
      description: desc
    };
    FB.ui(obj, callback);
  };

  window.fbAsyncInit = function() {
    FB.init({
      appId: "385604281606707",
      xfbml: true,
      version: "v2.2"
    });
  };

  (function(d, s, id) {
    var fjs, js;
    js = void 0;
    fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {
      return;
    }
    js = d.createElement(s);
    js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  })(document, "script", "facebook-jssdk");

  $(function() {
    $(".fbshare").on('click', function(e) {
      e.preventDefault();
      return window.open('https://www.facebook.com/sharer/sharer.php?u=' + location.href, 'sharer', 'width=626,height=436');
    });
    return $(".tweet-this").on('click', function(e) {
      e.preventDefault();
      return window.open(this.href, 'sharer', 'width=626,height=436');
    });
  });

}).call(this);
