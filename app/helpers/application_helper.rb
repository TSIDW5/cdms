module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning',
      notice: 'alert-info' }[flash_type.to_sym] || "alert-#{flash_type}"
  end

  def full_title(page_title = '', base_title = t('views.app.title'))
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def render_message(type, text)
    render partial: 'shared/multiple_flash_messages', locals: { type: type, text: text }
  end

  def render_messages(messages)
    messages ||= []
    messages.concat(flash.map { |k, v| { type: k.to_sym, text: v } }) if flash
    messages.select { |m| m[:type] == :error }.map { |m| render_message(m[:type], m[:text]) }.join
  end

end
