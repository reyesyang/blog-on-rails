init_wmd_editor = ->
  console.log 'init_wmd_editor'
  new WMDEditor
    input: "wmd",
    button_bar: "wmd-button-bar",
    preview: "wmd-preview",
    helpLink: "http://daringfireball.net/projects/markdown/syntax"

  $('#edit-area textarea').autoGrow()

$(document).on 'page:change', ->
  if $('#articles-new, #articles-edit').length > 0
    init_wmd_editor()
