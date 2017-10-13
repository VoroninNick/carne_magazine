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
  tl.set(article_title_selector, {opacity: 1})
  chars = mySplitText.chars

  #TweenLite.set(article_title_selector, {perspective:400});



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




  animateButton(".main-featured-article .article-category", 0.3, tl2)
  animateIssueNumber(".number", 0.3, tl3)
  tl3.fromTo(".magazine-name, .issue-date", 0.5, {opacity: 0}, {opacity: 1})
  #tl2.from(".author", 0.3, {opacity: 0})

  w = $(".banner-content").offset().left - 45 + 240

  tl2.fromTo(".banner-content .outer-separator", 0.3, {width: 0}, {width: w})

  tl2.staggerFromTo(".featured-articles .article", 0.5, {opacity: 0}, {opacity: 1}, 0.1)




animateButton = (jquery_element_or_selector, duration, timeline)->
  $button = $(jquery_element_or_selector)
  $bg = $button.find(".bg")
  $bg2 = $button.find(".bg2")
  $content = $button.find(".content")

  duration ?= 0.3
  timeline ?= new TimelineLite

  timeline.set($bg, {width: 0})
  timeline.fromTo($bg, duration, {width: 0}, {width: "100%"})

  timeline.fromTo($bg2, duration, {width: 0}, {width: "100%"})
  timeline.fromTo($content, 0.3, {opacity: 0}, {opacity: 1})

  timeline

animateIssueNumber = (selector, duration, timeline)->
  animateButton(selector, duration, timeline)

animateSidebar = (timeline)->
  #timeline.set(".bg, .bg2", {width: 0})
  timeline.fromTo(".sidebar-bg", 0.3, {width: 0}, {width: "100%"})
  timeline.fromTo(".sidebar-bg2", 0.3, {width: 0}, {width: "100%"})
  timeline.fromTo(".sidebar-inner", 0.3, {opacity: 0}, {opacity: 1})



window.animate_home_articles = ()->
  console.log "animate_home_articles"
  window.tl_home_articles ?= new TimelineLite
  tl_home_articles.set(".home-articles", {visibility: "visible", opacity: 1})
  #tl.set(".rect", {opacity: 1})
  tl_home_articles.set(".rect", {visibility: "visible"})
  tl_home_articles.delay(0.5)
  tl_home_articles.staggerFromTo(".rect-bgc", 0.5, {width: 0}, {width: "100%"}, 0.1)
  #tl.staggerFromTo(".rect-bgc", 0.5, {left: 0, width: "100%"}, {left: "100%", width: "100%"}, 0.1)
  tl_home_articles.staggerFromTo(".rect-bg", 0.5, {left: "-100%"}, {left: 0}, 0.1)
  tl_home_articles.staggerFromTo(".description-block", 0.5, {opacity: 0}, {opacity: 1}, 0.1)

animate_social_links = (jquery_element_or_selector, timeline)->
  $e = $(jquery_element_or_selector)
  timeline ?= new TimelineLite
  $links = $e.find(".share-link")
  timeline.delay(0.3)
  timeline.staggerFromTo($links, 0.3, {scale: 0, rotation: -180}, {scale: 1, rotation: 0}, 0.1)

  timeline



animateText = (jquery_element_or_selector, letter_duration, letter_delay, timeline)->
  $e = $(jquery_element_or_selector)
  timeline ?= new TimelineLite
  letter_duration ?= 0.4
  letter_delay ?= 0.04

  mySplitText = new SplitText($e, {type:"words,chars"})
  chars = mySplitText.chars

  timeline.staggerFrom(chars, letter_duration, {opacity:0,  ease:Back.easeOut}, letter_delay, "+=0");

  timeline

animate_home_banner()

#if $(".home-articles:appeared").length
#  animate_home_articles()

$document.on "appear_once", ".rect-container", (event, $all_appeared_elements)->
  animate_home_articles()


$document.on "appear_once", ".fadeInUp-tree *, .fadeInUp", ->
  $e = $(this)
  t = new TimelineLite
  t.fromTo($e, 2, {opacity: 0, y: "20%"}, {opacity: 1, y: "0%"})


$document.on "appear_once", ".article-label", ->
  $e = $(this)
  #t.fromTo($e, 2, {opacity: 0, y: "20%"}, {opacity: 1, y: "0%"})
  animateButton($e)



$document.on "appear_once", ".inline-article .article-category, .inline-article .article-title", ->
  $e = $(this)
  animateText($e)

$document.on "appear_once", ".socials", ->
  $e = $(this)
  animate_social_links($e)


