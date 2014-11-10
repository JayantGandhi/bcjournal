# some code for image previews...
readURL = (input) ->
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      $("#img_preview").attr "src", e.target.result
      return

    reader.readAsDataURL input.files[0]
  return
$ ->
  $("#post_cover_image").change ->
    readURL this
    return

  $('#post_tag_list').tagsInput()

  $('#slideshow_post_ids').chosen({
    no_results_text: "Nada, niente, rien",
    max_selected_options: 5
  })