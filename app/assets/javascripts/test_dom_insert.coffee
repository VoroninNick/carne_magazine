window.test_dom_insert = ()->
  s = ""
  for i in [0..250]
    s += "<div class='rect'></div>"

  $("#test-rect-container").html(s)