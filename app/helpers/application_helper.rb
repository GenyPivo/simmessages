module ApplicationHelper
  def nav_link(link_text, link_path, icon, **args)
    aclass = current_page?(link_path) ? 'active list-group-item' : 'list-group-item'
    content_tag(:a, class: aclass, href: link_path, 'data-method': args[:method]) do
      content_tag(:i, class: 'fa '.concat(icon)) {} + " #{link_text}"
    end
  end

  def messages_link(count)
    aclass = current_page?(messages_path) ? 'active list-group-item' : 'list-group-item'
    message_text = "#{count} NEW" unless count.zero?
    content_tag(:a, class: aclass, href: messages_path) do
      content_tag(:i, class: 'fa fa-comment-o') {} + ' Messages ' + content_tag(:data, message_text)
    end
  end

  def paginate(collection)
    will_paginate collection, renderer: BootstrapPagination::Rails if collection.present?
  end
end
