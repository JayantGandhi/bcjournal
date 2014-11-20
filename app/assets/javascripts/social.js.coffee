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
    appId: "your-app-id"
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

##############
# Twitter JS #
##############
window.twttr = ((d, s, id) ->
  t = undefined
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  return  if d.getElementById(id)
  js = d.createElement(s)
  js.id = id
  js.src = "https://platform.twitter.com/widgets.js"
  fjs.parentNode.insertBefore js, fjs
  window.twttr or (t =
    _e: []
    ready: (f) ->
      t._e.push f
      return
  )
(document, "script", "twitter-wjs"))