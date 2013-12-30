$ () ->
  $login_button = $("#login-button")
  $logout_button = $("#logout-button")

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

  $login_button.on "click", (e) ->
    e.preventDefault()
    navigator.id.request siteName: "Reyes Yang's Blog"

  $logout_button.on 'click', (e) ->
    e.preventDefault()
    return unless confirm("确定吗？")
    navigator.id.logout()
