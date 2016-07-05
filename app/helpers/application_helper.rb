module ApplicationHelper

  def error_messages(obj)
    return "" if obj.errors.empty?

    messages = obj.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = 'caguei'

    html = <<-HTML
    <div class="alert alert-warning alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <strong>#{sentence}</strong>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
    end
end
