test_dom_insert()

animate_rects = ()->
  t = new TimelineLite
  t.set("#test-rect-container", {})

  w = window.innerWidth / 25
  h = window.innerHeight / 25

  $rect_part1 = $("#test-rect-container .rect:lt(101)")
  $rect_part2 = $("#test-rect-container .rect:nth-child(1n+101):lt(101)")
  $rect_part3 = $("#test-rect-container .rect:nth-child(1n+201)")

  #t.staggerTo($rect, 0.1, {background: "red", width: w, height: h}, 0.1, "red")
  t.to($rect_part1, 5, {background: "red", width: w, height: h})
  t2 = new TimelineLite
  t2.delay(1)
  #t2.staggerTo($rect, 0.1, {background: "blue"}, 0.1)
  t2.to($rect_part2, 5, {background: "blue", width: w, height: h})


  t3 = new TimelineLite

  #t3.staggerTo($rect, 0.1, {background: "red", width: w, height: h}, "red_end")
  t3.to($rect_part3, 5, {background: "green", width: w, height: h})
  #t3.reverse()


animate_rects()