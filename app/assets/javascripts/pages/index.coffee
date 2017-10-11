animate_home_banner = ()->
  $home_banner = $(".main-banner")
  $home_banner.addClass("animated")
  $featured_block = $home_banner.find(".main-featured-article")
  article_title_selector = ".main-featured-article .article-name"
  $article_title = $featured_block.find(".article-name")
  #$article_title.animate({}, 500)
  #$bg = $home_banner.find(".main-banner-bg")


  window.tl = new TimelineLite
  mySplitText = new SplitText(article_title_selector, {type:"words,chars"})
  chars = mySplitText.chars

  TweenLite.set(article_title_selector, {perspective:400});

  tl.staggerFrom(chars, 0.4, {opacity:0,  ease:Back.easeOut}, 0.04, "+=0");

  window.tl2 = new TimelineLite
  tl2.set(".main-banner", {visibility:"visible"});
  tl2.delay(chars.length * 0.04)

  window.tl3 = new TimelineLite
  tl3.delay(1)
  tl3.set(".magazine-label", {visibility: "visible"})

  tl_sidebar = new TimelineLite
  tl_sidebar.set(".sidebar", {visibility: "visible"})
  tl_sidebar.delay(1)
  animateSidebar(tl3)




  animateButton(tl2, ".main-featured-article .article-category", 0.3)
  animateIssueNumber(tl3, ".number", 0.3)
  tl3.fromTo(".magazine-name, .issue-date", 0.5, {opacity: 0}, {opacity: 1})
  tl2.from(".author", 0.3, {opacity: 0})

  w = $(".banner-content").offset().left - 45 + 240

  tl2.fromTo(".banner-content .outer-separator", 0.3, {width: 0}, {width: w})

  tl2.staggerFromTo(".featured-articles .article", 0.5, {opacity: 0}, {opacity: 1}, 0.1)




animateButton = (timeline, selector, duration)->
  #timeline.fromTo(selector)
  timeline.set(selector + " .bg", {width: 0})
  timeline.fromTo(selector + " .bg", duration, {width: 0}, {width: "100%"})
  #timeline.to(selector + " .bg", 0.1, {background: "#1e4272"})
  #timeline.fromTo(selector + " .bg", duration, {width: "100%"}, {width: 0})
  #timeline.fromTo(selector + " .bg", duration, {background: "#fff", width: 0}, {width: "100%"})
  timeline.fromTo(selector + " .bg2", duration, {width: 0}, {width: "100%"})
  timeline.fromTo(selector + " .content", 0.3, {opacity: 0}, {opacity: 1})

animateIssueNumber = (timeline, selector, duration)->
  animateButton(timeline, selector, duration)

animateSidebar = (timeline)->
  #timeline.set(".bg, .bg2", {width: 0})
  timeline.fromTo(".sidebar-bg", 0.3, {width: 0}, {width: "100%"})
  timeline.fromTo(".sidebar-bg2", 0.3, {width: 0}, {width: "100%"})
  timeline.fromTo(".sidebar-inner", 0.3, {opacity: 0}, {opacity: 1})





animate_home_banner()