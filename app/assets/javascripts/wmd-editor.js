//= require wmd/wmd
//= require wmd/showdown

$(function() {
 new WMDEditor({
    input: "wmd",
    button_bar: "wmd-button-bar",
    preview: "wmd-preview",
    helpLink: "http://daringfireball.net/projects/markdown/syntax"
  });
})
