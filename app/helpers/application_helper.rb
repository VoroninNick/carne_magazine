module ApplicationHelper
  def placeholder_image_url(width, height)
    "http://lorempixel.com/#{width}/#{height}/"
  end

  def self.video_url(resource)
    if (!resource.respond_to?(:youtube_video_id) || resource.youtube_video_id.blank?) && (!resource.respond_to?(:vimeo_video_id) || resource.vimeo_video_id.blank?)
      return nil
    elsif resource.respond_to?(:youtube_video_id) && resource.youtube_video_id.present?
      return "https://www.youtube.com/watch?v=#{resource.youtube_video_id}"
    elsif resource.respond_to?(:vimeo_video_id) &&  resource.vimeo_video_id.present?
      return "https://vimeo.com/#{resource.vimeo_video_id}"
    end
  end


  def self.frame_video_url(resource)
    if (!resource.respond_to?(:youtube_video_id) || resource.youtube_video_id.blank?) && (!resource.respond_to?(:vimeo_video_id) || resource.vimeo_video_id.blank?)
      return nil
    elsif resource.respond_to?(:youtube_video_id) && resource.youtube_video_id.present?
      return "https://www.youtube.com/embed/#{resource.youtube_video_id}?controls=2&amp;showinfo=0&amp;autoplay=1&amp;autohide=1"
    elsif resource.respond_to?(:vimeo_video_id) &&  resource.vimeo_video_id.present?
      return "https://player.vimeo.com/video/#{resource.vimeo_video_id}?autoplay=1"
    end
  end
end
