test_dom_insert()

animate_rects = ()->
  t = new TimelineLite
  t.set("#test-rect-container", {})

  w = window.innerWidth / 25
  h = window.innerHeight / 25

  $rect = $("#test-rect-container .rect")

  t.staggerTo($rect, 0.1, {background: "red", width: w, height: h}, 0.1, "red")
  t2 = new TimelineLite
  t2.delay(1)
  t2.staggerTo($rect, 0.1, {background: "blue"}, 0.1)

  t3 = new TimelineLite
  t3.staggerTo($rect, 0.1, {background: "red", width: w, height: h}, "red_end")
  t3.reverse()


animate_rects()