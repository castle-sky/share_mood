module ApplicationHelper
  def full_title(title)
    base = "share mood"
    if title.nil?
      return title
    else
      return "#{title} | #{base}"
    end
  end
end
