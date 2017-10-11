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
  console.log "customScroll: delta: ", delta
  if delta
    scrollTop = $window.scrollTop()
    finScroll = scrollTop - (parseInt(delta * 100) * 4)
    TweenMax.to($window, 1.5,
      {
        scrollTo: {
          y: finScroll
          autoKill: true
        }
      }
      ease: Power4.easeOut
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
