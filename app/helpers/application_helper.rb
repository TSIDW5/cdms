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

  def current_path?(path)
    if request.path == path
      return 'list-group-item list-group-item-action active'
    else
      return 'list-group-item list-group-item-action'
    end
  end

end
