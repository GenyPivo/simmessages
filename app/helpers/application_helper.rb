module ApplicationHelper
  def nav_link(link_text, link_path, icon)
    aclass = current_page?(link_path) ? 'active list-group-item' : 'list-group-item'
    content_tag(:a, class: aclass, href: link_path) do
      content_tag(:i, class: 'fa '.concat(icon)) {} + " #{link_text}"
    end
  end
end
