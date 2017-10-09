$document.on "click", ".video-play-button", ->

  $this = $(@)
  $video_container = $this.closest('.video')
  $video_container.addClass("active")

  frame_video_url = $video_container.find('iframe').attr('data-video')
  $iframe = $video_container.find('iframe')
  $iframe.attr(src: frame_video_url)
