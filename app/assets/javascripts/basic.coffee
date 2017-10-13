customScroll = (event) ->
  if $('.showPopup').length
    return true

  delta = 0
  if !event
    event = window.event
  if event.wheelDelta
    delta = event.wheelDelta / 120
  else if event.detail
    delta = -event.detail / 3
  else if event.originalEvent && event.originalEvent.deltaY
    delta = -event.originalEvent.deltaY

  #console.log "customScroll: delta: ", delta
  if delta
    scrollTop = $window.scrollTop()
    increment = -1 * (parseInt(delta * 100) * 4)
    finScroll = scrollTop + increment

    console.log "finScroll: ", finScroll, "; delta: ", delta, increment: increment

    TweenMax.to($window, 1.5,
      {
        scrollTo: {
          y: finScroll
          autoKill: true
        }
      }
      #ease: Power4.easeOut
      ease: Elastic.easeOut.config(1, 0.3)
      overwrite: 5
      onComplete: ->
    )
  if event.preventDefault
    event.preventDefault()
  event.returnValue = false
  #console.log "customScroll: e: ", event


scroll_delay = ()->
  delay("custom_scroll", customScroll, 50, true, false)

$document.on "mousewheel", scroll_delay
if $document.addEventListener
  document.addEventListener('DOMMouseScroll', customScroll, false)

$appearable_elements = $(".appear, .appear-tree *")
$appearable_elements.appear()



appear_handler = (event, $all_appeared_elements)->
  $all_appeared_elements.each(
    ()->
      $e = $(this)
      appeared = $e.data("_appeared")
      if !appeared
        $e.data("_appeared", true)
        $e.trigger("appear_once", event, $all_appeared_elements, $e)
        $e.addClass("appeared")
        $tree_root = $e.closest(".appear-tree")
        $tree_root.trigger("appear:tree:node", event, $all_appeared_elements, $e)

  )

$document.on "appear", "*", appear_handler
#appear_handler.call(this, {}, $appearable_elements.filter(":appeared"))


page_loaded_handler = ()->
  $('body').addClass('loaded');
  $('#loader-wrapper').fadeOut(
    complete: ()->
      $.force_appear()
      $window.trigger("after_preloader")
  );


window.addEventListener('load', page_loaded_handler)
