###############
# Facebook JS #
###############
postToFeed = (title, desc, url, image) ->
  callback = (response) ->
  obj =
    method: "feed"
    link: url
    picture: "http://www.url.com/images/" + image
    name: title
    description: desc

  FB.ui obj, callback
  return
window.fbAsyncInit = ->
  FB.init
    appId: "591649337603308"
    xfbml: true
    version: "v2.1"

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
    postToFeed elem.data("title"), elem.data("desc"), elem.prop("href"), elem.data("image")
    false

##############
# Twitter JS #
##############
