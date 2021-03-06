(function() {
  var readURL;

  readURL = function(input) {
    var reader;
    if (input.files && input.files[0]) {
      reader = new FileReader();
      reader.onload = function(e) {
        var backgroundStyle;
        backgroundStyle = 'background-image:url(' + e.target.result + ')';
        $("#img_preview").attr("style", backgroundStyle);
      };
      reader.readAsDataURL(input.files[0]);
    }
  };

  $(function() {
    $("#post_cover_image").change(function() {
      readURL(this);
    });
    $('#post_tag_list').tagsInput();
    return $('#slideshow_post_ids').chosen({
      no_results_text: "Nada, niente, rien",
      max_selected_options: 5
    });
  });

}).call(this);
