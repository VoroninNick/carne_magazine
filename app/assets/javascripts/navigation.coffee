$document.on "scrolldelta", (e)->


  $block = get_current_color_block()

  #console.log "scrolldelta: block length: ", $block.length

  navigation_dark = $block.hasClass("light-bg")
  navigation_light = !navigation_dark

  $label = $(".magazine-label")

  if navigation_dark
    if !$label.hasClass("dark")
      $label.addClass("dark")
  else
    if $label.hasClass("dark")
      $label.removeClass("dark")


window.get_current_color_block = ()->
  $blocks = $(".light-bg, .dark-bg")
  scroll_top = $("body").scrollTop() || $("html").scrollTop() || $window.scrollTop()
  scroll_bottom = scroll_top + window.innerHeight
  $blocks.filter(
    ()->
      $b = $(this)
      block_top = $b.offset().top
      block_bottom = block_top + $b.outerHeight()
      label_bottom = 150
      block_top <= scroll_top && block_bottom >= scroll_top + label_bottom
  ).last()


$document.on "click", ".sidebar-navigation .item:not(.active)", (e)->
  e.preventDefault()
  $item = $(this)
  $container = $item.parent()
  $container.children().filter(".active").removeClass("active")
  $item.addClass("active")

  k = $item.attr("data-key")
  $block = $("[data-navigation-key='#{k}']")
  block_top = $block.offset().top
  $("body,html").animate({scrollTop: block_top}, 400)


