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

  def asset_to_string(name)
    app = Rails.application
    if Rails.configuration.assets.compile
      app.assets.find_asset(name).to_s
    else
      controller.view_context.render(file: File.join('public/assets', app.assets_manifest.assets[name]))
    end
  end

  def inline_css(name)
    extensions = ["css", "scss", "sass"]
    name = extensions.any?{|s| name.end_with?(".#{s}") } ? name : "#{name}.css"
    str = minify_css(asset_to_string(name))
    if str.present?
      "<style>#{str}</style>".html_safe
    else
      ""
    end
  end

  def inline_js(name)
    extensions = ["js", "coffee"]
    name = extensions.any?{|s| name.end_with?(".#{s}") } ? name : "#{name}.js"
    str = (asset_to_string(name))
    if str.present?
      "<script type='text/javascript'>#{str.inspect}</script>".html_safe
    else
      ""
    end
  end
  def minify_css(str)
    #str.gsub(/\/\*[\sa-zA-Z0-9\/\,\.]{0,}\*\//, "")
    #Uglifier.new.compile(str)

    #str
    str.gsub(/\/\*[\sa-zA-Z\_0-9\,\/\.]{0,}\*\//, "").gsub(/\s\{/, "{").gsub(/\}[\s]{1,}]/, "}").gsub(/\;\s/, ";").gsub(/\s\;/, ";").gsub(/\{\s/, "{").gsub(/\;\s/, ";").gsub(/\A\s/, "").gsub(/\s\Z/, "").gsub(/\A\s?\Z/, "")
    .gsub(/\{[\s]{1,}/, "{").gsub(", ", ",").gsub("\n", "").gsub("; ", ";").gsub(": ", ":").gsub(/\}[\s]{1,}/, "}").gsub(";}", "}")
  end

  def minify_js(str)
    str
  end
end
