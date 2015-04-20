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
    $('#post_tag_list').tagsInput({
      'width': '100%'
    });
    $('#post_author_list').tagsInput({
      'defaultText': 'add an author',
      'width': '100%'
    });
    $('#slideshow_post_ids').chosen({
      no_results_text: "Nada, niente, rien",
      max_selected_options: 5
    });
    $("#issue_cover_image").change(function() {
      readURL(this);
    });
    $('#issue_post_ids').chosen({
      no_results_text: "Nada, niente, rien"
    });
    return $('#post_post_ids').chosen({
      no_results_text: "Nada, niente, rien",
      max_selected_options: 4
    });
  });

}).call(this);
