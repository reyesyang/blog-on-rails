navigator.id.watch
  loggedInUser: $.cookie('email') || null
  onlogin: (assertion) ->
    $.ajax
      type: 'POST'
      url: '/login.json'
      data: {
        assertion: assertion
      }
      success: (res, status, xhr) ->
        window.location.reload()
      error: (xhr, status, error) ->
        alert("Login Failed!")

  onlogout: () ->
    $.ajax
      type: 'DELETE',
      url: '/logout.json',
      success: (res, status, xhr) ->
        window.location.reload()
      error: (xhr, status, error) ->
        alert("Logout Failed")

$(document).on "click", '#login-button', (e) ->
  e.preventDefault()
  navigator.id.request siteName: "Reyes Yang's Blog"

$(document).on 'click', '#logout-button', (e) ->
  e.preventDefault()
  return unless confirm("确定吗？")
  navigator.id.logout()
