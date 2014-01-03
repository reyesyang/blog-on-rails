$(document).on 'page:fetch', -> NProgress.start()
$(document).on 'page:change', -> NProgress.done()
$(document).on 'page:restore', -> NProgress.remove()

$(document).on 'page:update', ->
  if $.cookie('admin') isnt "true"
    $('.admin').remove()
