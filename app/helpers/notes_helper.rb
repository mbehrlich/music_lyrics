module NotesHelper
  include ERB::Util

  def ugly_lyrics(lyrics)
    display = lyrics.split("\r\n")
    display = display.map { |line| "&#9835; " + h(line) }.join("\r\n")
    display = "<pre>" + display + "</pre>"
    display.html_safe
  end

end
