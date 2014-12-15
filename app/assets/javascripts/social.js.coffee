###############
# Facebook JS #
###############
postToFeed = (title, desc, url, image) ->
  callback = (response) ->
  obj =
    method: "feed"
    link: url
    picture: image
    name: title
    description: desc

  FB.ui obj, callback
  return



window.fbAsyncInit = ->
  FB.init
    appId: "385604281606707"
    xfbml: true
    version: "v2.2"

  return

((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  return  if d.getElementById(id)
  js = d.createElement(s)
  js.id = id
  js.src = "//connect.facebook.net/en_US/sdk.js"
  fjs.parentNode.insertBefore js, fjs
  return
) document, "script", "facebook-jssdk"

$ ->
  $(".fb-share").click ->
    elem = $(this)
    FB.ui
      method: "share_open_graph"
      action_type: "og.likes"
      action_properties: JSON.stringify(object: elem.prop("href"))
    , (response) ->
    # postToFeed elem.data("title"), elem.data("desc"), elem.prop("href"), elem.data("image")
    # false

##############
# Twitter JS #
##############
